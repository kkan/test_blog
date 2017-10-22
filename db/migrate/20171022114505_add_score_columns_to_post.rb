class AddScoreColumnsToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :reviews_count, :integer, default: 0
    add_column :posts, :scores_sum, :integer
  end
end
