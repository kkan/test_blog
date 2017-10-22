class PostsController < ApplicationController
  def create
    post_form = Forms::PostForm.new(post_params)
    result = Creators::PostCreator.new(post_form).process
    if result.success?
      post_fields = result.objects[:post].attributes.slice('id', 'title', 'content')
      render json: { post: post_fields }
    else
      render json: { errors: result.errors }, code: 422
    end
  end

  def top
    posts_number = params[:n].presence
    posts = Post.top(posts_number).select(:id, :title, :content)
    render json: { posts: posts }
  end

  private

  def post_params
    params.permit(:title, :content, :ip, :login)
  end
end
