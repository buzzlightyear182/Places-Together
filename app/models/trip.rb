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
	validates :description, presence: true
	validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_blank: true

	validate :from_date_is_in_future
	validate :from_date_before_to_date
	validate :no_duplicates

	def no_duplicates

	end

  def create_participation current_user
    Participation.create user_id: current_user.id, trip_id: id, confirmed: true
  end

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

	def reviewable? current_user
		if has_passed && (if_participant? current_user)
			@can_review
		else
			[]
		end
	end

	def joinable? current_user
		return true if capacity.nil?

		get_count_of_people
		current_trip_size = @count[:confirmed_people]
		if (if_participant? current_user) || (capacity == current_trip_size)
			false
		else
			true
		end
	end

	def get_count_of_people
		@count = {}
		@count[:pending_people] = (get_trip_participants false).length
		@count[:confirmed_people] = (get_trip_participants true).length
		@count
	end

	def has_passed
		to_date < Date.today
		# Date.today <= Date.today+1
	end

	def if_participant? current_user
		get_trip_participants true
		@can_review.include? current_user.id
	end

	def get_trip_participants status
		@participations = Participation.where(trip_id: self.id, confirmed: status)
		@can_review = []
		@participations.each do |p|
			@can_review << p.user_id
		end
		(@can_review.uniq! == nil) ? @can_review : @can_review.uniq!
	end

	def self.update_trip (params, trip_id, organizer_id)
		trip = Trip.find(trip_id)
		trip.save_trip_info(params, organizer_id)
		trip
	end

	def self.create_new_trip (params, organizer_id)
		trip = Trip.new
		trip.save_trip_info(params, organizer_id)
		trip
	end

	def save_trip_info(params, organizer_id)
		self.place_id = check_place params["place"]
		activity =
			if (params["activity_create"] == "")
				params["activity"]
			else
				params["activity_create"]
			end

		self.activity_id = check_activity activity
		self.organizer = organizer_id
		self.from_date = params["from_date"]
		self.to_date = params["to_date"]
		self.capacity = params["capacity"]
		self.description = params["description"]
	end

	def name
		"#{activity.activity_name} in #{place.city}"
	end

	private

	def check_place city
		city.capitalize!
		current_place = Place.where(city: city)
		if current_place.exists?
			current_place[0].id
		else
			new_place = Place.create(city: city)
			new_place.id
		end
	end

	def check_activity activity
		activity = activity.capitalize
		current_activity = Activity.where(activity_name: activity)
		if current_activity.exists?
			current_activity[0].id
		else
			new_activity = Activity.create(activity_name: activity, category: "Others")
			new_activity.id
		end
	end

end
