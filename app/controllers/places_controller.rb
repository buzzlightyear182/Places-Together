class PlacesController < ApplicationController

	def index
		@places = Place.all
	end

end
