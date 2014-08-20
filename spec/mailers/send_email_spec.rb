require "rails_helper"
require 'pry'

RSpec.describe SendEmail, :type => :mailer do

  before(:each) do
    @test_user = User.create(username: "username01", fullname: "Test User", password: "12345678", email: "test_user@gmail.com")

    @p_user = User.create(username: "participant", fullname: "Test Participant", password: "12345678", email: "test_participant@gmail.com")

    @place = Place.create(city: "Barcelona", country: "Spain")

    @activity = Activity.create(activity_name: "Ironhack", category: "Studies")

    @trip = Trip.create organizer: @test_user.id, place_id: @place.id, activity_id: @activity.id, from_date: Date.today+1, to_date: Date.today+3, capacity: 3, description: "Web Development Intensive Bootcamp"

    @participation = Participation.create(trip_id: @trip.id, user_id: @p_user.id, confirmed: false)

    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

describe "When someone wants to join a trip, it" do

  before(:each) do
    SendEmail.to_notify_organizer(@participation).deliver
  end

  it 'should send an email to the organizer' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

	it 'renders the receiver email' do
    expect(ActionMailer::Base.deliveries.first.to).to eq([@test_user.email])
  end

  it 'should set the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq("Someone wants to join you in #{@place.city}")
  end

	it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(["janeheatherdee@gmail.com"])
  end
end

describe "When the trip organizer adds you to the trip, it" do

  before(:each) do
    SendEmail.to_notify_joiner(@participation).deliver
  end

  it 'should send an email to the joiner' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the receiver email' do
    expect(ActionMailer::Base.deliveries.first.to).to eq([@p_user.email])
  end

  it 'should set the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq("#{@test_user.username} just added you for a trip to #{@place.city}")
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(["janeheatherdee@gmail.com"])
  end
end

end
