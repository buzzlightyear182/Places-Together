class Review < ActiveRecord::Base
  belongs_to :profile
  belongs_to :trip

  validates :author_id, presence: true
  validates :reviewee_id, presence: true
  validates :trip_id, presence: true
  validates :rating, presence: true, numericality: true

  def self.find_common_trip(reviewer_id, reviewee_id)
    reviewer_trips = find_participation_of reviewer_id
    reviewee_trips = find_participation_of reviewee_id

    @common_trip_ids = reviewer_trips & reviewee_trips
    @common_trips = {}
    @common_trip_ids.map do |trip_id|
      h = {}
      place = Place.find(Trip.find(trip_id).place_id).city
      activity = Activity.find(Trip.find(trip_id).activity_id).activity_name
      h[activity + " in " + place] = trip_id
      @common_trips.merge! h
    end
    @common_trips
  end

  def self.find_participation_of user_id
    user_participation = Participation.where(user_id: user_id).all
    @user_trips = []
    user_participation.each do |user|
      @user_trips << user.trip_id
    end
    @user_trips
  end

  def self.create_review(params, author_id, reviewee_id)
    @review = Review.new
    @review.author_id = author_id
    @review.reviewee_id = reviewee_id
    @review.trip_id = params[:trip].to_i
    @review.content = params[:content]
    @review.rating = params[:rating]
    @review
  end

end
