class PostCreator
  def initialize(post_form)
    @post_form = post_form
  end

  def process
    @result = Result.new
    create_post_for_user
    @result
  end

  private

  def create_post_for_user
    return @result.errors << @post_form.errors unless @post_form.valid?

    ActiveRecord::Base.transaction(isolation: :serializable) do
      user = User.find_or_create_by!(login: @post_form.login)
      post = Post.create!(user: user,
                          title: @post_form.title,
                          content: @post_form.content,
                          ip: @post_form.ip)
      @result.objects.merge!(user: user, post: post)
    end
  rescue ActiveRecord::StatementInvalid => e
    retry if e.message =~ /PG::TRSerializationFailure/
    @result.errors << { key: :creating_error, details: e.message }
  end
end

class Result
  attr_reader :errors, :objects

  def initialize
    @errors = []
    @objects = {}
  end

  def success?
    errors.empty?
  end
end
