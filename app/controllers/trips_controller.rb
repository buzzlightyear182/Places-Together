class TripsController < ApplicationController
	respond_to :json, :html

	before_action :authenticate_user!, except: [:index]

	def index
		 @search = Search.new
		if params[:place_id]
			@place = Place.find(params[:place_id])
			@trips = Trip.where(place_id: @place.id).all
			@link = '/places/'+params[:place_id]+'/trips/calendar'
		elsif params[:activity_id]
			@activity= Activity.find(params[:activity_id])
			@trips = Trip.where(activity_id: @activity.id).all
			@link = '/activities/'+params[:activity_id]+'/trips/calendar'
		end
	end

	def calendar
		@search = Search.new
		if params[:place_id]
			@place = Place.find(params[:place_id])
			@trips = Trip.where(place_id: @place.id).all
		elsif params[:activity_id]
			@activity= Activity.find(params[:activity_id])
			@trips = Trip.where(activity_id: @activity.id).all
		end
	end

	def show
		@search = Search.new
		@trip = Trip.find(params[:id])
		pending_people = @trip.get_trip_participants false
		confirmed_people = @trip.get_trip_participants true
		@count_of_people = [pending_people.length, confirmed_people.length]
		@review_members = @trip.reviewable? current_user
	end

	def new
		@search = Search.new
		@trip = Trip.new
		place = params[:place]
		activity = params[:activity]
		@filler = [place, activity]
		@activities = Activity.all.limit(10)
	end

	def create
		@activities = Activity.all.limit(10)
		organizer_id = current_user.id
		@trip = Trip.create_new_trip(trip_params, organizer_id)
			if @trip.save
				@trip.create_participation current_user
				flash[:notice] = "Trip has been created!"
				redirect_to action: 'show', id: @trip.id
			else
			flash[:alert] = @trip.errors.full_messages
			render 'new'
			end
	end

	def edit #only if current_user = organizer
		@search = Search.new
		@trip = Trip.find(params[:id])
		@activities = Activity.all.limit(10)
		if @trip.organizer == current_user.id
			@place = @trip.place.city
			@activity = @trip.activity.activity_name
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
				flash[:alert]	=	@trip.errors.full_messages
				render 'edit'
		end
	end

	def destroy
		@trip = Trip.find(params[:id])
		Participation.destroy_all(trip_id: @trip.id)
		@trip.destroy
		flash[:notice] = "Trip has been cancelled!"
		redirect_to action: 'index', controller: 'places'
	end

private

	def trip_params
		params.require(:trip).permit(:place, :activity, :activity_create, :from_date, :to_date, :capacity, :description)
	end

end
