class PlacesActivitiesRelation < ActiveRecord::Migration
  def change
  	create_table :places_activities do |t|
	  	t.belongs_to :place
			t.belongs_to :activity
		end
  end
end
