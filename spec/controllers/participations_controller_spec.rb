require 'rails_helper'
require 'pry'

RSpec.describe ParticipationsController, :type => :controller do

describe "When a member joins a trip" do

	before(:each)do
		@test_user = User.create(username: "username01", fullname: "Test User", password: "12345678", email: "test_user@gmail.com")
		@place = Place.create(city: "Barcelona", country: "Spain")
		@activity = Activity.create(activity_name: "Ironhack", category: "Studies")
		@trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
	end

	it "records the member who wants to join that trip" do
		@participation = Participation.create(trip_id: @trip.id, user_id: @test_user.id)
    expect(Participation.all.count).to eq(1)
  end

  # it "should go back to show the trip details" do
  # 	@participation = Participation.create(trip_id: @trip.id, user_id: @test_user.id)

  # 	get :show, :controller =>'trips', 'id' => @trip.id
  #   expect(response).to redirect_to(action: 'show', :controller =>'trips')
  # end

end

end
