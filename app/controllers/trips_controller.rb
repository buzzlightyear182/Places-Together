class TripsController < ApplicationController
	require 'pry'

	# before_action :authenticate_user!, except: [:index]

	def index
		if params[:place_id]
			@place = Place.find(params[:place_id])
			@trips = Trip.where(place_id: @place.id).all
		elsif params[:activity_id]
			@activity= Activity.find(params[:activity_id])
			@trips = Trip.where(activity_id: @activity.id).all
		end
	end

	def show
		@trip = Trip.find(params[:id])
		@pending_people = Participation.where(trip_id: @trip.id, confirmed: false).all.count
		@confirmed_people = Participation.where(trip_id: @trip.id, confirmed: true).all.count
	end

	def new
		@trip = Trip.new
	end

	def create
		organizer_id = current_user.id
		@trip = Trip.create_new_trip(trip_params, organizer_id)
		@trip.save
		if @trip.save
			render 'show'
		else
			@errors = @trip.errors.full_messages
			render 'new'
		end
	end

private

	def trip_params
		params.require(:trip).permit(:place, :activity, :from_date, :to_date, :capacity, :description)
	end

end
