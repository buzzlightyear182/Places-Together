require 'pry'

class Profile < ActiveRecord::Base
  belongs_to :user
  # accepts_nested_attributes_for :links
  serialize :links
  serialize :languages

end
