class PlacesController < ApplicationController

	def index
		@places = Place.all.limit(10)
    @search = Search.new
	end

end
