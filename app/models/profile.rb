require 'pry'

class Profile < ActiveRecord::Base
  belongs_to :user
  serialize :links
  serialize :languages

  def self.update_profile(params, id)
    @profile = Profile.find(id)
    @profile.update_attributes! params
    @profile.languages = params["languages"].split(",")
    binding.pry
    @profile.save
  end
end
