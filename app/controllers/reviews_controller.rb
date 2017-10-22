class ReviewsController < ApplicationController
  def create
    review_form = Forms::ReviewForm.new(review_params)
    result = Creators::ReviewCreator.new(review_form).process
    if result.success?
      render json: { rating: result.objects[:post].rating.round(2) }
    else
      render json: { errors: result.errors }, code: 422
    end
  end

  private

  def review_params
    params.permit(:post_id, :score)
  end
end
