class Place < ActiveRecord::Base
	has_and_belongs_to_many :activities
	has_many :trips
	belongs_to :user

	validates :city, presence: true
	validates :country, format: {with: /\A[a-zA-Z]+\z/}

end
