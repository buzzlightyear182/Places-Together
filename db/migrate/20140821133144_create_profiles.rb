class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string  :first_name
      t.string  :surname
      t.float   :rating
      t.string  :occupation
      t.date    :birthday
      t.string  :hometown
      t.timestamps
    end
  end
end
