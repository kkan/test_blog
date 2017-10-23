class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :ip_users, dependent: :destroy
end
