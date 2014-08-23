class Review < ActiveRecord::Base
  belongs_to :profile
  belongs_to :trip

  validates :author_id, presence: true
  validates :reviewee_id, presence: true
  validates :trip_id, presence: true
  validates :rating, presence: true, numericality: true
end
