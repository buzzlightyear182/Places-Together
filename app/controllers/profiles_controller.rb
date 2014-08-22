require 'pry'

  # <%= input name="profile[links][<%= key %>]" type="text" value="<%= value %>" %>

class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.where(user_id: current_user.id).first
  end

  def update
    @profile_id = Profile.where(user_id: current_user.id).first.id
    @profile = Profile.update_profile(profile_params, @profile_id)
    binding.pry
    if @profile
        redirect_to action: 'show', id: @profile.id
        flash[:notice] = "Profile updated!"
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
