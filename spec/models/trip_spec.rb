require 'rails_helper'

RSpec.describe Trip, :type => :model do

  before :each do
    @test_user = FactoryGirl.build(:user)
    @place = FactoryGirl.build(:place)
    @activity = FactoryGirl.build(:activity)
  end

	describe "should not be valid when it" do

  	it "does not have any place" do
      trip = FactoryGirl.build(:trip, place: nil)
  		expect(trip).to be_invalid
  	end

  	it "does not have any activity" do
  		trip = FactoryGirl.build(:trip, activity: nil)
  		expect(trip).to be_invalid
  	end

  	it "there is no organizer" do
  		trip = FactoryGirl.build(:trip, organizer: nil)
      expect(trip).to be_invalid
  	end

  	it "from_date is not in the future" do
      trip = FactoryGirl.build(:trip, from_date: Date.today-2)
  		expect(trip).to be_invalid
  	end

  	it "to_date should be before from_date" do
      trip = FactoryGirl.build(:trip, to_date: Date.today-5)
  		expect(trip).to be_invalid
  	end

  	it "capacity should be greater than 0" do
      trip = FactoryGirl.build(:trip, capacity: 0)
      expect(trip).to be_invalid
  	end
  end

end
