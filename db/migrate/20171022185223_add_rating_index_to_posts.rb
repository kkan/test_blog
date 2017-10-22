class AddRatingIndexToPosts < ActiveRecord::Migration[5.1]
  def change
    add_index :posts, 'rating DESC NULLS LAST'
  end
end
