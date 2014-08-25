require 'rails_helper'
require 'pry'
RSpec.describe ReviewsController, :type => :controller do

  before :each do
    @test_user = User.create(username: "username01", password: "12345678", email: "test_user@gmail.com")
    @place = Place.create(city: "Barcelona", country: "Spain")
    @second_place = Place.create(city: "Madrid", country: "Spain")
    @activity = Activity.create(activity_name: "Ironhack", category: "Studies")
    @trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
    @trip.generate_trip_name
    @trip.create_participation @test_user
    @p_user = User.create(username: "participant", password: "12345678", email: "p_user@gmail.com")
    @member01 = Participation.create trip_id: @trip.id, user_id: @p_user.id, confirmed: true

    @second = Trip.create organizer: @test_user.id, place_id: @second_place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Practicing everyday, let's meet at Parque del Retiro"
    @second.generate_trip_name
    @second.create_participation @test_user
    @member02 = Participation.create trip_id: @second.id, user_id: @p_user.id, confirmed: true
  end

  it "finds common trips of the author and reviewee" do
    user_id = @test_user.id
    joiner_id = @p_user.id
    common_trips = Review.find_common_trip(user_id, joiner_id)
    expect(common_trips.length).to eq(2)
    expect(common_trips.keys).to eq([@trip.name, @second.name])
  end

  describe "When a review is saved" do

    before :each do
      @profile = Profile.create user_id: @p_user.id
      review_params = {
        content: "User is a good traveller",
        rating: 8,
        trip: @trip.id
      }

      @review = Review.create_review(review_params, @test_user.id, @profile.id)
      @review.save
      @profile.update_rating
    end

    it "should automatically update profile rating" do
      review_params2 = {
        content: "User is the best traveller",
        rating: 10,
        trip: @second.id
      }
      @review2 = Review.create_review(review_params2, @test_user.id, @profile.id)
      @review2.save
      @profile.update_rating
      expect(@profile.rating).to eq(9)
    end
  end

end
