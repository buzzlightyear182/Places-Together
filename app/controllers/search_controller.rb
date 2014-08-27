class SearchController < ApplicationController

  def create
    @search = Search.new
    @trips = @search.search(params[:search][:keyword])
    unless @trips == nil
      flash[:notice] = "Sorry no results found"
    else
      flash[:success] = "Here are your search results"
    end
    render 'trips/index'
  end
end
