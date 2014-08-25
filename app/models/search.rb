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
    place_result = Place.where(city: keyword).first
    activity_result = Activity.where(activity_name: keyword).first

    if place_result != nil
      @search_results = Trip.where(place_id: place_result.id).all
    elsif activity_result != nil
      @search_results = Trip.where(activity_id: activity_result.id).all
    end

    @search_results
  end

end
