class TripsController < ApplicationController

	before_action :authenticate_user!, except: [:index]

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
		@trip = Trip.create_new_trip trip_params
		@trip.save
		if @trip
			flash[:notice] = "Trip created!"
			render 'show'
		else
			@errors = @trip.errors.full_messages
			render 'new'
		end
	end

private

	def trip_params
		params.require(:trip).permit(:organizer, :place, :activity, :from_date, :to_date, :capacity, :description)
	end

end
