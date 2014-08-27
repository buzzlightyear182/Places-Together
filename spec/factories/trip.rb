FactoryGirl.define do

  factory :trip do
    from_date Date.today+1
    to_date Date.today+3
    capacity 3
    description "Web Development Intensive Bootcamp"
  end

end
