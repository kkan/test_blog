class PostsController < ApplicationController
  def create
    post_form = PostForm.new(post_params)
    result = PostCreator.new(post_form).process
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

  def multiuser_ip_addresses
    ips = IpUser.multiuser_ips.map{ |iu| { ip: iu.ip.to_s, logins: iu.logins } }
    render json: { ips: ips }
  end

  private

  def post_params
    params.permit(:title, :content, :ip, :login)
  end
end
