class Place < ActiveRecord::Base
	has_and_belongs_to_many :activities
	has_many :trips

	validates :city, presence: true

end
