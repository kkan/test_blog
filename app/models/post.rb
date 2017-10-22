class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  def rating
    0
  end
end
