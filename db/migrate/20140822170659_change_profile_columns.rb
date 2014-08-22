class ChangeProfileColumns < ActiveRecord::Migration
  def change
    add_column :profiles, :facebook, :string
    add_column :profiles, :twitter, :string
    add_column :profiles, :instagram, :string
    add_column :profiles, :google, :string
    add_column :profiles, :blog, :string
    add_column :profiles, :others, :string
  end
end
