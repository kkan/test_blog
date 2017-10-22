class PostCreator < ObjectCreator
  def process
    super
    create_post_for_user
    @result
  end

  private

  def create_post_for_user
    return @result.errors += @form_object.errors.full_messages unless @form_object.valid?

    ActiveRecord::Base.transaction(isolation: :serializable) do
      user = User.find_or_create_by!(login: @form_object.login)
      post = Post.create!(user: user,
                          title: @form_object.title,
                          content: @form_object.content,
                          ip: @form_object.ip)
      ip_user = IpUser.find_or_create_by!(user: user, ip: @form_object.ip)
      @result.objects.merge!(user: user, post: post, ip_user: ip_user)
    end
  rescue ActiveRecord::StatementInvalid => e
    retry if e.message =~ /PG::TRSerializationFailure/
    @result.errors << e.message
  end
end
