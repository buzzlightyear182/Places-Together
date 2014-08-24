class AddTripName < ActiveRecord::Migration
  def change
    add_column :trips, :name, :string
  end
end
