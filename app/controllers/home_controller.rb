class HomeController < ApplicationController

  def welcome
    @search = Search.new
  end

  def my_trips
    @search = Search.new
    @trips = Trip.where(organizer: current_user.id)
    if @trips == nil
      flash[:notice] = "You don't have any trips yet! Why not create one?"
    else
      @trips
    end
    render 'mytrips'
  end

  def my_pending_trips
    @search = Search.new
    trips = Trip.where(organizer: current_user.id)
    @trips = []
    trips.each do |trip|
      if trip.to_date > Date.today
        @trips << trip
      end
    end

    if @trips == nil
      flash[:notice] = "You don't have any pending trips! Why not create a new one?"
    else
      @trips
    end
    render 'mytrips'
  end

end
