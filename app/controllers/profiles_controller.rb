require 'pry'

class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
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
    params.require(:profile).permit(:first_name, :surname, :hometown, :birthday, :occupation, :languages, links: [:Facebook, :Twitter, :Instagram, :Google, :Blog])
  end

end
