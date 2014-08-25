require 'rails_helper'
require 'pry'

RSpec.describe TripsController, :type => :controller do

	before(:each)do
		@test_user = User.create(username: "username01", password: "12345678", email: "test_user@gmail.com")
		@place = Place.create(city: "Barcelona", country: "Spain")
		@activity = Activity.create(activity_name: "Ironhack", category: "Studies")
    # current_user = @test_user
	end

	it "shows all the trips from a specific place" do
    get :index, place_id: @place.id
    expect(response).to render_template(:index)
  end

  it "shows all the trips for a specific activity" do
    get :index, activity_id: @activity.id
    expect(response).to render_template(:index)
  end

	xit "show the trip details from a specific trip" do
  	trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
    get :show, id: trip.id
    expect(response).to render_template(:show)
  end

  it "will not create a trip if the user isn't logged-in" do
    organizer_id = nil
    trip_params = {
    	"place" => @place.city,
      "activity" => "",
    	"activity_create" => @activity.activity_name,
      "from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}

    previous_trip_count = Trip.all.count
  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save
    expect(Trip.all.count).to eq(previous_trip_count)
  end

  describe "creates a trip" do

    it "and a place when place is not existing" do
    organizer_id = @test_user.id
    @new_place = Place.create city: "Madrid", country: "Spain"
    trip_params = {
    	"place" => @new_place.city,
      "activity" => @activity.activity_name,
    	"activity_create" => "",
			"from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}

    previous_trip_count = Trip.all.count
  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save

    expect(Place.last.city).to eq(@new_place.city)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

  it "but doesn't create the place because of case difference" do
    organizer_id = @test_user.id
    @new_place = Place.create city: "barcelona", country: "Spain"
    trip_params = {
      "place" => @new_place.city,
      "activity" => @activity.activity_name,
      "activity_create" => "",
      "from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
      "capacity" => "3",
      "description" => "Web Development Intensive Bootcamp"
      }

    previous_trip_count = Trip.all.count

    @trip = Trip.create_new_trip(trip_params, organizer_id)
    @trip.save

    expect(Place.last.city).to eq(@place.city)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

  it "and an activity when activity is not existing" do
    organizer_id = @test_user.id
    @new_activity = Activity.create activity_name: "Writing code", category: "Geek"
    trip_params = {
    	"place" => @place.city,
      "activity" => "",
    	"activity_create" => @new_activity.activity_name,
			"from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
    	"capacity" => "3",
    	"description" => "Web Development Intensive Bootcamp"
    	}
    previous_trip_count = Trip.all.count

  	@trip = Trip.create_new_trip(trip_params, organizer_id)
  	@trip.save

    expect(Activity.last.activity_name).to eq(@new_activity.activity_name)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

  it "but doesn't create the activity because of case difference" do
    organizer_id = @test_user.id
    @new_activity = Activity.create activity_name: "ironhack", category: "Geek"
    trip_params = {
      "place" => @place.city,
      "activity" => "",
      "activity_create" => @new_activity.activity_name,
      "from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
      "capacity" => "3",
      "description" => "Web Development Intensive Bootcamp"
      }

    previous_trip_count = Trip.all.count

    @trip = Trip.create_new_trip(trip_params, organizer_id)
    @trip.save

    expect(Activity.last.activity_name).to eq(@activity.activity_name)
    expect(Trip.all.count).to eq(previous_trip_count+1)
  end

  it "place and an activity when both place and activity is not existing" do
    organizer_id = @test_user.id
    @new_place = Place.create city: "Madrid", country: "Spain"
    @new_activity = Activity.create activity_name: "Writing code", category: "Geek"
    trip_params = {
    	"place" => @new_place.city,
      "activity" => "",
    	"activity_create" => @new_activity.activity_name,
			"from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
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
    	"activity_create" => "",
			"from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
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

  it "and automatically generates a trip name" do
    organizer_id = @test_user.id
    trip_params = {
      "place" => @place.city,
      "activity" => @activity.activity_name,
      "activity_create" => "",
      "from_date"=>"2015-10-21",
      "to_date"=>"2015-11-21",
      "capacity" => "3",
      "description" => "Web Development Intensive Bootcamp"
      }

    @trip = Trip.create_new_trip(trip_params, organizer_id)
    @trip.generate_trip_name
    @trip.save

    expect(@trip.name).to eq("Ironhack in Barcelona")
  end
end

  xdescribe "display trip details" do

    before :each do
      @organizer = @test_user
      @p_user = User.create(username: "participant", password: "12345678", email: "p_user@gmail.com")
      @sure_user = User.create(username: "surejoiner", password: "12345678", email: "sure_user@gmail.com")
      current_user = @test_user
    end

    it "and number of people confirmed and pending approval" do

      trip_params = {
        "place" => @place.city,
        "activity" => @activity.activity_name,
        "activity_create" => "",
        "from_date"=>"2014-09-01",
        "to_date"=>"2014-09-03",
        "capacity" => "3",
        "description" => "Web Development Intensive Bootcamp"
        }

      @trip = Trip.create_new_trip(trip_params, @organizer.id)
      @trip.create_participation @organizer
      @trip.save

      @pending = Participation.create trip_id: @trip.id, user_id: @p_user.id, confirmed: false
      @sure = Participation.create trip_id: @trip.id, user_id: @sure_user.id, confirmed: true
      get :show, id: @trip.id
      expect(@count_of_people).to eq([1,1])
    end

    it "but not confirmed participants when to_date is not passed" do
      trip_params = {
        "place" => @place.city,
        "activity" => @activity.activity_name,
        "activity_create" => "",
        "from_date"=>"2014-08-25",
        "to_date"=>"2014-08-26",
        "capacity" => "3",
        "description" => "Web Development Intensive Bootcamp"
        }

      @trip = Trip.create_new_trip(trip_params, @organizer.id)
      @trip.create_participation @organizer
      @trip.save

      @pending = Participation.create trip_id: @trip.id, user_id: @p_user.id, confirmed: false
      @sure = Participation.create trip_id: @trip.id, user_id: @sure_user.id, confirmed: true
      get :show, id: @trip.id
      expect(@review_members).to eq(nil)
    end

    it "but not confirmed participants when current_user is not part of the trip" do
    end

    it "and confirmed participants when reviewable" do
    end
  end

end
