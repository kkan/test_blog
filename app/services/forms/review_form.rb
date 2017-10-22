module Forms
  class ReviewForm < BaseForm
    attr_reader :score, :post_id

    validates :score, numericality: { greater_than_or_equal_to: 1,
                                      less_than_or_equal_to: 5,
                                      only_integer: true }
    validates :post_id, presence: true

    def initialize(params)
      @score = params[:score]
      @post_id = params[:post_id]
    end
  end
end
