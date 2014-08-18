class Activity < ActiveRecord::Base
	has_and_belongs_to_many :places
	has_many :trips
	belongs_to :user

	validates :activity_name, presence: true
	validates :user_id, presence: true
end
