class TripsController < ApplicationController

	def index
		@place = Place.find(params[:place_id])
		@trips = Trip.where(place_id: @place.id).all
	end

	def show
		@trip = Trip.find(params[:id])
	end

	def new
		@trip = Trip.new
	end

	def create
		@trip = Trip.create_new_trip(trip_params)
	end

private

	def trip_params
		params.require(:trip).permit(:place, :activity, :from_date, :to_date, :capacity, :description)
	end

end
