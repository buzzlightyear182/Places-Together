class Activity < ActiveRecord::Base
	has_many :places, through: :trips

	validates :activity_name, presence: true,uniqueness: {case_sensitive: false}

  def self.categories
    @category_list = []
    all_activities = self.all
    all_activities.each do |activity|
      @category_list << activity.category
    end
    @category_list.uniq! == nil ? @category_list : @category_list.uniq!
    @category_list
  end
end
