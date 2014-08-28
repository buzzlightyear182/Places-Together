class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all.limit(10)
    @search = Search.new
  end

  def filter
    @activities = Activity.where(category: params[:category])
  end

end
