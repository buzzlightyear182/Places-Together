class Trip < ActiveRecord::Base
	belongs_to :place
	belongs_to :activity
	belongs_to :user
	has_many :users, through: :participation

	validates :organizer, presence: true
	validates :place_id, presence: true
	validates :activity_id, presence: true
	validates :from_date, presence: true
	validates :to_date, presence: true
	validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

	validate :from_date_is_in_future
	validate :from_date_before_to_date

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

	# def reviewable?(user)
	# 	to_date < Time.now && dvdsvs
	# end

	def self.update_trip (params, trip_id, organizer)
		@trip = Trip.find(trip_id)
		@trip.place_id = check_place params["place"]

		activity =
			if (params["activity_create"] == "")
				params["activity"]
			else
				params["activity_create"]
			end

		@trip.activity_id = check_activity activity
		@trip.organizer = organizer
		@trip.from_date = params["from_date"]
		@trip.to_date = params["to_date"]
		@trip.capacity = params["capacity"]
		@trip.description = params["description"]
		@trip
	end

	def self.create_new_trip (params, user_id)
		@trip = Trip.new
		@trip.place_id = check_place params["place"]

		activity =
			if (params["activity_create"] == "")
				params["activity"]
			else
				params["activity_create"]
			end

		@trip.activity_id = check_activity activity
		@trip.organizer = user_id
		@trip.from_date = params["from_date"]
		@trip.to_date = params["to_date"]
		@trip.capacity = params["capacity"]
		@trip.description = params["description"]
		@trip
	end

	def self.check_place city
		city.capitalize!
		current_place = Place.where(city: city)
		if current_place.exists?
			current_place[0].id
		else
			new_place = Place.create(city: city)
			new_place.id
		end
	end

	def self.check_activity activity
		activity = activity.capitalize
		current_activity = Activity.where(activity_name: activity)
		if current_activity.exists?
			current_activity[0].id
		else
			new_activity = Activity.create(activity_name: activity)
			new_activity.id
		end
	end

end
