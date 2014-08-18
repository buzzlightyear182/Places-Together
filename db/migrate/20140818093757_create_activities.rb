class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
			t.string :activity_name
			t.string :category
      t.timestamps
    end
  end
end
