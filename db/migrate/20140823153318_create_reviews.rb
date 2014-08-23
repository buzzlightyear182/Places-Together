class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :author_id
      t.integer :reviewee_id
      t.integer :trip_id
      t.text    :content
      t.float   :rating
      t.timestamps
    end
  end
end
