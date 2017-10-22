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
    ActiveRecord::Base.transaction(isolation: :serializable) do
      review = Review.create!(post: post, score: @form_object.score)
      post.update!(rating: post.calculate_rating)
      @result.objects.merge!(review: review, post: post)
    end
  rescue ActiveRecord::RecordNotFound => e
    @errors << e.message
  rescue ActiveRecord::StatementInvalid => e
    retry if e.message =~ /PG::TRSerializationFailure/
    @result.errors << e.message
  end
end
