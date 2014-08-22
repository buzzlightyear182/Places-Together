require 'rails_helper'

RSpec.describe ParticipationsController, :type => :controller do

	before(:each)do
		@test_user = User.create(username: "username01", password: "12345678", email: "test_user@gmail.com")
		@place = Place.create(city: "Barcelona", country: "Spain")
		@activity = Activity.create(activity_name: "Ironhack", category: "Studies")
		@trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
		@participation = Participation.create trip_id: @trip.id, user_id: @test_user.id, confirmed: false
	end

describe "When a member wants to join a trip, it" do

	it "records the member who wants to join that trip" do
    expect(Participation.all.count).to eq(1)
  end

end

describe "When an organizer clicks the add to trip button in email, it" do

	it "should add joiner to the trip" do
		get :add_joiner, id: @participation
		@participation.reload
		expect(@participation.confirmed).to eq(true)
	end

end

end
