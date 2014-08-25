class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all
    @search = Search.new
  end

end
