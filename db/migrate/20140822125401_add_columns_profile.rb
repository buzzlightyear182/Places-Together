class AddColumnsProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :languages, :text, default: ["English"]
  end
end
