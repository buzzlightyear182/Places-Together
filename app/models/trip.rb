class Trip < ActiveRecord::Base
	# has_many_and_belongs_to_many :users
	belongs_to :place
	has_one :activity

	validates :place_id, presence: true
	validates :activity_id, presence: true
	validates :from_date, presence: true
	validates :to_date, presence: true

	validate :from_date_is_in_future
	validate :from_date_before_to_date

#custom ActiveRecord validations

	def from_date_is_in_future
		if from_date == nil
			return
		elsif Date.today > from_date
			errors.add(:from_date, "should be in the future")
		end
	end

	def from_date_before_to_date
		if from_date == nil
			return
		elsif from_date > to_date
			errors.add(:to_date, "should be after its beginning")
		end
	end

end
