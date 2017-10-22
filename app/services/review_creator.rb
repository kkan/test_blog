class ReviewCreator < ObjectCreator
  def process
    super
    create_review
    @result
  end

  private

  def create_review
    return @result.errors += @form_object.errors.full_messages unless @form_object.valid?

    post = Post.find(@form_object.post_id)
    review = Review.create(post: post, score: @form_object.score)
    @result.objects[:review] = review
  rescue ActiveRecord::RecordNotFound => e
    @errors << 'Post not found'
  end
end
