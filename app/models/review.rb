require 'pry'
class Review < ActiveRecord::Base
  belongs_to :profile
  belongs_to :trip

  validates :author_id, presence: true
  validates :reviewee_id, presence: true
  validates :trip_id, presence: true
  validates :rating, presence: true, numericality: true

  def self.find_common_trip(reviewer_id, reviewee_id)
    reviewer_participation = Participation.where(user_id: reviewer_id).all
    reviewer_trips = []
    reviewer_participation.each do |reviewer|
      reviewer_trips << reviewer.trip_id
    end
    reviewer_trips.uniq! ? reviewer.trips.length > 1 : reviewer_trips

    reviewee_participation = Participation.where(user_id: reviewee_id).all
    reviewee_trips = []
    reviewee_participation.each do |reviewee|
      reviewee_trips << reviewee.trip_id
    end
    reviewee_trips.uniq! ? reviewee.trips.length > 1 : reviewee_trips

    @common_trips_id = reviewer_trips & reviewee_trips
    get_trip_names @common_trips_id
  end

  def self.get_trip_names id_array
    id_array.map! do |trip_id|
      place = Place.find(Trip.find(trip_id).place_id).city
      activity = Activity.find(Trip.find(trip_id).activity_id).activity_name
      activity + " in " + place
    end
    @common_trips = id_array
  end
end
