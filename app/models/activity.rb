class Activity < ActiveRecord::Base
	has_and_belongs_to_many :places
	has_many :trips

	validates :activity_name, presence: true
end
