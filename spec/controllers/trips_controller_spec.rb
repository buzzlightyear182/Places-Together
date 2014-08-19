require 'rails_helper'

RSpec.describe TripsController, :type => :controller do

	before(:each)do
		@test_user = User.create(username: "username01", fullname: "Test User", password: "12345678", email: "test_user@gmail.com")
		@place = Place.create(city: "Barcelona", country: "Spain")
		@activity = Activity.create(activity_name: "Ironhack", category: "Studies")
	end

	it "shows all the trips from a specific place" do
  	trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
    get :index, place_id: @place.id
    expect(response).to render_template(:index)
  end

	it "show the trip details from a specific trip" do
  	trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
    get :show, id: trip.id
    expect(response).to render_template(:show)
  end

  it "will not create a trip if the user isn't logged-in" do
    organizer_id = nil
    trip_params = {
    	"place" => @place.city,
    	"activity" => @activity.activity_name,
			"from_date(1i)"=>"2014",
			"from_date(2i)"=>"8",
			"from_date(3i)"=>"26",
			"to_date(1i)"=>"2014",
			"to_date(2i)"=>"8",
			"to_date(3i)"=>"30",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}

    previous_trip_count = Trip.all.count
  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save
    expect(Trip.all.count).to eq(previous_trip_count)
  end

  describe "create a trip" do

    it "and a place when place is not existing" do
    organizer_id = @test_user.id
    @new_place = Place.new city: "Madrid", country: "Spain"
    trip_params = {
    	"place" => @new_place.city,
    	"activity" => @activity.activity_name,
			"from_date(1i)"=>"2014",
			"from_date(2i)"=>"8",
			"from_date(3i)"=>"26",
			"to_date(1i)"=>"2014",
			"to_date(2i)"=>"8",
			"to_date(3i)"=>"30",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}

    previous_trip_count = Trip.all.count

  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save

    expect(Place.last.city).to eq(@new_place.city)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

  it "and an activity when activity is not existing" do
    organizer_id = @test_user.id
    @new_activity = Activity.new activity_name: "Writing code", category: "Geek"
    trip_params = {
    	"place" => @place.city,
    	"activity" => @new_activity.activity_name,
			"from_date(1i)"=>"2014",
			"from_date(2i)"=>"8",
			"from_date(3i)"=>"26",
			"to_date(1i)"=>"2014",
			"to_date(2i)"=>"8",
			"to_date(3i)"=>"30",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}
    previous_trip_count = Trip.all.count

  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save

    expect(Activity.last.activity_name).to eq(@new_activity.activity_name)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

  it "place and an activity when both place and activity is not existing" do
    organizer_id = @test_user.id
    @new_place = Place.new city: "Madrid", country: "Spain"
    @new_activity = Activity.new activity_name: "Writing code", category: "Geek"
    trip_params = {
    	"place" => @new_place.city,
    	"activity" => @new_activity.activity_name,
			"from_date(1i)"=>"2014",
			"from_date(2i)"=>"8",
			"from_date(3i)"=>"26",
			"to_date(1i)"=>"2014",
			"to_date(2i)"=>"8",
			"to_date(3i)"=>"30",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}

    previous_trip_count = Trip.all.count

  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save

    expect(Activity.last.activity_name).to eq(@new_activity.activity_name)
    expect(Place.last.city).to eq(@new_place.city)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

	it "and not create any place or activity since both options exist already" do
    organizer_id = @test_user.id
    trip_params = {
    	"place" => @place.city,
    	"activity" => @activity.activity_name,
			"from_date(1i)"=>"2014",
			"from_date(2i)"=>"8",
			"from_date(3i)"=>"26",
			"to_date(1i)"=>"2014",
			"to_date(2i)"=>"8",
			"to_date(3i)"=>"30",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}

    previous_trip_count = Trip.all.count

  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save

  	expect(Activity.last.activity_name).to eq(@activity.activity_name)
    expect(Place.last.city).to eq(@place.city)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

end

end
