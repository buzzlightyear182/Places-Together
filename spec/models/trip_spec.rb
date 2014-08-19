require 'rails_helper'

RSpec.describe Trip, :type => :model do

	describe "should be valid when" do

	before(:each)do
		@test_user = User.create(username: "username01", fullname: "Test User", password: "12345678", email: "test_user@gmail.com")
		@place = Place.create(city: "Barcelona", country: "Spain")
		@activity = Activity.create(activity_name: "Ironhack", category: "Studies")
	end

	it "it has_one place" do
		trip = Trip.create organizer: @test_user.id, place_id: nil, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
		expect(trip.errors.full_messages).to eq(["Place can't be blank"])
	end

	it "it has_one activity" do
		trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: nil, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
		expect(trip.errors.full_messages).to eq(["Activity can't be blank"])
	end

	it "it belongs_to an organizer" do
		trip = Trip.create organizer: nil, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
		expect(trip.errors.full_messages).to eq(["Organizer can't be blank"])
	end

	it "from_date is not in the future" do
		trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today-2, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
		expect(trip.errors.full_messages).to eq(["From date should be in the future"])
	end

	it "to_date should be before from_date" do
		trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today-5, capacity: 3, description: "Web Development Intensive Bootcamp"
		expect(trip.errors.full_messages).to eq(["To date should be after its beginning"])
	end
end
end
