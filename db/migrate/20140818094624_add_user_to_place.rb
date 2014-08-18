class AddUserToPlace < ActiveRecord::Migration
  def change
  	add_column :places, :user_id, :integer
  	add_column :activities, :user_id, :integer
  end
end
