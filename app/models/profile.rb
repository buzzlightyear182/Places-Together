class Profile < ActiveRecord::Base
  belongs_to :user
  serialize :links
  serialize :languages

  def update_rating
    @reviews = Review.where(reviewee_id: self.id).all
    scores = []
    @reviews.each do |r|
      scores << r.rating
    end
    self.rating = scores.inject(0.0) { |sum, el| sum + el }/scores.size
    save
  end
end
