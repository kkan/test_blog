class PostCreator < ObjectCreator
  def process
    super
    create_post_for_user
    @result
  end

  private

  def create_post_for_user
    return @result.errors += @object_form.errors.full_messages unless @object_form.valid?

    ActiveRecord::Base.transaction(isolation: :serializable) do
      user = User.find_or_create_by!(login: @object_form.login)
      post = Post.create!(user: user,
                          title: @object_form.title,
                          content: @object_form.content,
                          ip: @object_form.ip)
      @result.objects.merge!(user: user, post: post)
    end
  rescue ActiveRecord::StatementInvalid => e
    retry if e.message =~ /PG::TRSerializationFailure/
    @result.errors << details: e.message
  end
end
