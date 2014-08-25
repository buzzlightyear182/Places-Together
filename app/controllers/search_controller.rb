class SearchController < ApplicationController

  def create
    @search = Search.new
    @search_results = @search.search(params[:search][:keyword])
    render 'search/index'
  end
end
