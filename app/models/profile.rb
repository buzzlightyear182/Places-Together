class Profile < ActiveRecord::Base
  belongs_to :user
  serialize :links
  serialize :languages

  # def get_trip_names_of user_participations
  #   @profile_trips = []
  #   user_participations.each do |trip_id|
  #     trip = Trip.find(trip_id)
  #     @profile_trips << trip.name
  #   end
  #   self
  # end
end
