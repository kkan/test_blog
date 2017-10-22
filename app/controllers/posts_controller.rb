class PostsController < ApplicationController
  def create
    post_form = PostForm.new(post_params)
    result = PostCreator.new(post_form).process
    if result.success?
      render json: { post: result.objects[:post] }
    else
      render json: { errors: result.errors }, code: 422
    end
  end

  private

  def post_params
    params.permit(:title, :content, :ip, :login)
  end
end
