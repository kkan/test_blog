class PostsController < ApplicationController
  def create
    post_form = PostForm.new(post_params)
    result = PostCreator.new(post_form).process
    if result.success?
      @post = result.objects[:post]
      render json: @post
    else
      @errors = result.errors
      render json: @errors
    end
  end

  private

  def post_params
    params.permit(:title, :content, :ip, :login)
  end
end
