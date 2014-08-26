require 'rails_helper'

RSpec.describe Review, :type => :model do
  describe 'validation' do
    it 'only allows reviews on finished trips' do
      trip = test_trip
      review = Review.new(trip: trip)

      review.valid?.should be_falsy
      review.errors[:trip].should eq(["Must be finished"])
    end

    it 'allows reviews on finished trips' do
      trip = test_trip
      trip.from_date = 4.weeks.ago
      trip.to_date = 3.weeks.ago
      trip.save(validate: false)

      review = Review.new(trip: trip)
      review.valid?
      p review.errors
      review.valid?.should be_truthy
      review.errors[:trip].should be_nil
    end

  end

end
