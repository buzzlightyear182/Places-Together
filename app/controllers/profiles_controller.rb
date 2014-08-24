class ProfilesController < ApplicationController

    before_action :authenticate_user!, except: [:show]


  def show
    @profile = Profile.find(params[:id])
    @reviews = Review.where(reviewee_id: params[:id])
    @reviews if @reviews != []
    user_participations = Review.find_participation_of params[:id]
    @profile_trips = Review.connect_trip_name user_participations
  end

  def edit
    @profile = Profile.where(user_id: current_user.id).first
  end

  def update
    @profile = Profile.where(user_id: current_user.id).first
    @profile.update_attributes! profile_params
    @profile.languages = profile_params["languages"].split(",")
    if @profile.save
      flash[:notice] = "Profile updated!"
      render 'show'
    else
      @errors = @profile.errors.full_messages
      render 'edit'
    end
  end

private

  def profile_params
    params.require(:profile).permit(:first_name, :surname, :hometown, :birthday, :occupation, :languages, :facebook, :twitter, :instagram, :google, :blog)
  end

end
