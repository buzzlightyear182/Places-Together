class TripsController < ApplicationController

	def index
		@place = Place.find(params[:place_id])
		@trips = Trip.where(place_id: @place.id).all
	end

	def show
		# place = Place.find_by(params[:place_id])
		@trip = Trip.find(params[:id])
	end
end
