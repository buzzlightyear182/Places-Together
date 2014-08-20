require 'pry'

class ParticipationsController < ApplicationController

	def new
		#confirmation alert?
	end

	def create
		@trip = Trip.find(params[:trip_id])
		@participation = Participation.new user_id:current_user.id, trip_id: @trip.id, confirmed:  false
		@participation.save
		flash[:notice] = "Organizer has been notified."
		redirect_to action:'show', :controller =>'trips', id: @trip.id
	end
end
