FactoryGirl.define do
  factory :activity do
    activity_name "Ironhack"
    category "Studies"
  end

  factory :new_activity do
    activity_name "Visit"
    category "Tourism"
  end
end
