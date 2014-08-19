require 'pry'

class Trip < ActiveRecord::Base
	has_one :place
	has_one :activity
	belongs_to :user

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

#custom trip creation method
	def self.create_new_trip params
		trip = Trip.new
		trip.place_id = check_place(params["place"])
		trip.activity_id = check_activity(params["activity"])
		binding.pry
		redirect to action: 'show'
	end

	def self.check_place city
		current_city = Place.where(city: city)
		binding.pry
		if current_city.exists?
			current_city.id
		else
			new_place = Place.create(city: city)
			new_place.id
		end
	end

	def self.check_activity activity
		current_activity = Activity.where(activity_name: activity)
		binding.pry
		if current_activity.exists?
			current_activity.id
		else
			new_activity = Activity.create(activity_name: activity)
			new_activity.id
		end
	end

end