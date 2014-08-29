class ProfilesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def show
    @search = Search.new
    @profile = Profile.find(params[:id])
    @reviews = Review.where(reviewee_id: params[:id])
    @reviews if @reviews != []
    user_participations = Review.find_participation_of params[:id]
    @profile_trips = Review.connect_trip_name user_participations
  end

  def edit
    @search = Search.new
    @profile = Profile.where(user_id: current_user.id).first
  end

  def update
    @profile = Profile.where(user_id: current_user.id).first
    @profile.update_attributes! profile_params
    @profile.languages = profile_params["languages"].split(",")
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to action: 'show', id: @profile.id
    else
      @errors = @profile.errors.full_messages
      flash[:error] = @errors.first
      render 'edit'
    end
  end

private

  def profile_params
    params.require(:profile).permit(:first_name, :surname, :hometown, :birthday, :occupation, :languages, :facebook, :twitter, :instagram, :google, :blog)
  end

end
