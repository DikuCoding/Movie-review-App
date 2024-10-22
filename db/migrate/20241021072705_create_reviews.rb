class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.integer :movie_id
      t.integer :user_id
      t.text :comment
      t.float :rating

      t.timestamps
    end
  end
end
