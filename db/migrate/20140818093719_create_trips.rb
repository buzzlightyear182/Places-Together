class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
			t.integer :organizer
			t.integer :place_id
			t.integer :activity_id
			t.date :from_date
			t.date :to_date
			t.text :description
			t.integer :capacity
      t.timestamps
    end
  end
end
