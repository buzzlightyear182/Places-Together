FactoryGirl.define do

  factory :trip do
    organizer
    place {FactoryGirl.create(:place)}
    activity {FactoryGirl.create(:activity)}
    from_date Date.today+1
    to_date Date.today+3
    capacity 3
    description "Web Development Intensive Bootcamp"
  end

end
