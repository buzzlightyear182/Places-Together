require 'pry'
class Profile < ActiveRecord::Base
  belongs_to :user
  serialize :links
  serialize :languages

  def update_rating
    @profile = Profile.find(self.id)
    @reviews = Review.where(reviewee_id: self.id).all
    scores = []
    @reviews.each do |r|
      scores << r.rating
    end
    @profile.rating = scores.inject(0.0) { |sum, el| sum + el }/scores.size
    @profile.save
  end
end
