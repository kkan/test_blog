class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  def calculate_rating
    scores = reviews.pluck(:score)
    return nil if scores.size.zero?
    scores.sum.to_f / scores.size
  end
end
