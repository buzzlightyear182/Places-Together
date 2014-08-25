class PlacesController < ApplicationController

	def index
		@places = Place.all
    @search = Search.new
	end

end
