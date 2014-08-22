class TripsController < ApplicationController

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
		@temporary_place = params[:place]
		@temporary_activity = params[:activity]
		@activities = Activity.all.limit(10)
	end

	def create
		@activities = Activity.all.limit(10)
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

	def edit #only if current_user = organizer
		@trip = Trip.find(params[:id])
		@activities = Activity.all.limit(10)
		if @trip.organizer == current_user.id
			@place = Place.find(@trip.place_id).city
			@activity = Activity.find(@trip.activity_id).activity_name
			render 'edit'
		else
			flash[:alert] = "Sorry you are not the organizer of this trip."
			redirect_to action: 'show', id: @trip.id
		end
	end

	def update
		@activities = Activity.all.limit(10)
		organizer_id = current_user.id
		@trip = Trip.update_trip(trip_params, params[:id], organizer_id)
		if @trip.save
				redirect_to	action: 'show', id: @trip.id
				flash[:notice] = "Trip updated!"
		else
				@trip	=	@trip.errors.full_messages
				render 'edit'
		end
	end

private

	def trip_params
		params.require(:trip).permit(:place, :activity, :activity_create, :from_date, :to_date, :capacity, :description)
	end

end
