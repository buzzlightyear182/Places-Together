class PlacesController < ApplicationController

	def index
		@places = Place.all
		@activities = Activity.all
    if current_user
      @profile_id = Profile.where(user_id: current_user.id).first.user_id
    end
	end

end
