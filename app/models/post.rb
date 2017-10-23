class Post < ApplicationRecord
  DEFAULT_TOP_POSTS_NUMBER = 100

  belongs_to :user
  has_many :reviews, dependent: :destroy

  def self.top(n = nil)
    n ||= DEFAULT_TOP_POSTS_NUMBER
    order('posts.rating DESC NULLS LAST').limit(n)
  end

  def add_score(new_score)
    self.reviews_count += 1
    self.scores_sum = scores_sum.to_i + new_score
    self.rating = scores_sum.to_f / reviews_count
  end
end
