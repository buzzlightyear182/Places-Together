require 'rails_helper'

RSpec.describe ParticipationsController, :type => :controller do

	before(:each)do
		@test_user = User.create(username: "username01", password: "12345678", email: "test_user@gmail.com")
		@place = Place.create(city: "Barcelona", country: "Spain")
		@activity = Activity.create(activity_name: "Ironhack", category: "Studies")
		@trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
		@trip.create_participation @test_user
		@p_user = User.create(username: "participant", password: "12345678", email: "p_user@gmail.com")
	end

describe "When an organizer creates a trip, it" do

	it "should automatically record its participation" do
    expect(Participation.all.count).to eq(1)
  end

end

describe "When a member wants to join a trip, it" do

	it "records the member who wants to join that trip" do
    @pending = Participation.create trip_id: @trip.id, user_id: @p_user.id, confirmed: false
    expect(Participation.all.count).to eq(2)
  end

end

describe "When an organizer clicks the add to trip button in email, it" do

	it "should add joiner to the trip" do
	 @pending = Participation.create trip_id: @trip.id, user_id: @p_user.id, confirmed: false
		get :add_joiner, id: @pending
		@pending.reload
		expect(@pending.confirmed).to eq(true)
	end

end

end
