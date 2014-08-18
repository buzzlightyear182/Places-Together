class User < ActiveRecord::Base
	# has_many_and_belongs_to :trips
	has_many :places
	has_many :activities
end
