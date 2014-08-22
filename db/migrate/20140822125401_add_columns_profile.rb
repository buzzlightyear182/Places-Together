class AddColumnsProfile < ActiveRecord::Migration
  def change
    # remove_column :profiles, :language
    add_column :profiles, :links, :text, default: {:Facebook => "", :Twitter => "", :Instagram => "", :Google => "", :Blog => ""}
    add_column :profiles, :languages, :text, default: ["English"]
  end
end
