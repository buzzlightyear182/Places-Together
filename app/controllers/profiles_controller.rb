class ProfilesController < ApplicationController

  def new
  end

  def create_profile
    redirect_to action: 'index', controller: 'places'
  end

  def edit
  end

  def update
  end

end
