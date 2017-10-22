class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :post, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
