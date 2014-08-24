require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do

  before(:each)do
    @test_user = User.create(username: "username01", password: "12345678", email: "test_user@gmail.com")
    @place = Place.create(city: "Barcelona", country: "Spain")
    @activity = Activity.create(activity_name: "Ironhack", category: "Studies")
    @trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"
    @p_user = User.create(username: "participant", password: "12345678", email: "p_user@gmail.com")
    @sure_user = User.create(username: "surejoiner", password: "12345678", email: "sure_user@gmail.com")
    @pending = Participation.create trip_id: @trip.id, user_id: @p_user.id, confirmed: false
    @sure = Participation.create trip_id: @trip.id, user_id: @sure_user.id, confirmed: true
    current_user = @test_user
  end

  it "automatically creates a profile when a user signs-up" do
    expect(Profile.all.count).to eq(3)
  end

  xit "should display the user's profile information and reviews (if any)" do
    get :show, id: @test_user.id
    expect(response).to render_template(:show)
  end

  xit "will not editable if the current user is not the owner" do
    get :edit, id: @p_user.id
    expect(response).to render_template(:show)
  end

end
