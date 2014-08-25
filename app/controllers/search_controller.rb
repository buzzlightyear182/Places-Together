class SearchController < ApplicationController

  def create
    @search = Search.new
    @trips = @search.search(params[:search][:keyword])
    render 'trips/index'
  end
end
