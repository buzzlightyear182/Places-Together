class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all.limit(10)
    @search = Search.new
  end

end
