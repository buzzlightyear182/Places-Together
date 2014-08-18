class Activity < ActiveRecord::Base
	has_many :places, through: :trips

	validates :activity_name, presence: true
end
