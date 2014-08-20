class PlacesController < ApplicationController

	def index
		@places = Place.all
		@activities = Activity.all
	end

end
