class AddParticipantConfirmation < ActiveRecord::Migration
  def change
  	add_column :participations, :confirmed, :boolean
  end
end
