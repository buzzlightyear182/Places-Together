# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
  	activity_name Faker::Lorem.words(2, true)
  	category Faker::Lorem.word
  end
end
