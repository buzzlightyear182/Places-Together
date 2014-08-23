class Profile < ActiveRecord::Base
  belongs_to :user
  serialize :links
  serialize :languages

end
