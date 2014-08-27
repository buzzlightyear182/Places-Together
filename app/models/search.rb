class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :keyword
  # , :search_results

  def initialize
    self.keyword = keyword
    # @search_results = []
  end

  def search(keyword)
    place_result = Place.where('city ILIKE ?', "%#{keyword}%")
    activity_result = Activity.where('activity_name ILIKE ?', "%#{keyword}%")

    if place_result.size != 0
      place_result.each do |place|
        @search_results = Trip.where(place_id: place.id).all
      end
    elsif activity_result.size != 0
      activity_result.each do |activity|
        @search_results = Trip.where(activity_id: activity_result.id).all
      end
    end

    @search_results

  end

end
