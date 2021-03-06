module Creators
  class ReviewCreator < BaseCreator
    def process
      super
      create_review
      @result
    end

    private

    def create_review
      return write_form_errors unless @form_object.valid?

      ActiveRecord::Base.transaction(isolation: :serializable) do
        post = Post.find(@form_object.post_id)
        review = Review.create!(post: post, score: @form_object.score)
        post.add_score(@form_object.score)
        post.save!
        @result.objects.merge!(review: review, post: post)
      end
    rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound => e
      retry if e.message =~ /PG::TRSerializationFailure/
      @result.errors << e.message
    end
  end
end
