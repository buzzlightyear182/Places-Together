class Place < ActiveRecord::Base
	has_many :activities, through: :trips

	validates :city, presence: true, uniqueness: {case_sensitive: false}

end
