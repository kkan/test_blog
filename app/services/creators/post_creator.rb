module Creators
  class PostCreator < BaseCreator
    def process
      super
      create_post_for_user
      @result
    end

    private

    def create_post_for_user
      return write_form_errors unless @form_object.valid?

      ActiveRecord::Base.transaction(isolation: :serializable) do
        user = User.find_or_create_by!(login: @form_object.login)
        post = Post.create!(post_params)
        ip_user = IpUser.find_or_create_by!(ip_user_params) if @form_object.ip
        @result.objects.merge!(user: user, post: post, ip_user: ip_user)
      end
    rescue ActiveRecord::StatementInvalid => e
      retry if e.message =~ /PG::TRSerializationFailure/
      @result.errors << e.message
    end

    def post_params
      {
        user: user,
        title: @form_object.title,
        content: @form_object.content,
        ip: @form_object.ip
      }
    end

    def ip_user_params
      { user: user, ip: @form_object.ip }
    end
  end
end
