require 'pry'

class ParticipationsController < ApplicationController

	def new
		#confirmation alert?
	end

	def create
		@trip = Trip.find(params[:trip_id])
		@participation = Participation.new user_id:current_user.id, trip_id: @trip.id, confirmed: false
		@participation.save
		SendEmail.to_notify_organizer(@participation).deliver
		flash[:notice] = "Organizer has been notified."
		redirect_to action:'show', :controller =>'trips', id: @trip.id
	end

	def add_joiner
		@participation = Participation.find(params[:id])
		if @participation
			@participation.update!(confirmed: true)
			redirect_to action: 'show', controller: 'trips'
		else
			redirect_to action: 'new', controller: 'sessions'
		end
	end

end
