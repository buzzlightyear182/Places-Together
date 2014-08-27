FactoryGirl.define do
  factory :participation do
    trip
    test_user
    confirmed true
  end

  factory :not_approved do
    trip
    participant
    confirmed false
  end

  factory :approved do
    trip
    confirmed_user
    confirmed true
  end
end
