class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(user)
    flash[:notice] = "Get started by creating your profile"
    edit_profile_path(user)
  end
end
