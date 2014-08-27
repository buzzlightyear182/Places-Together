FactoryGirl.define do
  factory :user, aliases: [:organizer] do
    username "test_user"
    email "test_user@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :participant do
    username "participant"
    password "password"
    email "participant@gmail.com"
  end

  factory :pending_user do
    username "pending_user"
    password "password"
    email "pending_user@gmail.com"
  end

  factory :confirmed_user do
    username "confirmed_user"
    password "password"
    email "confirmed_user@gmail.com"
  end

  after(:create) do |user|
    FactoryGirl.create(:profile)
  end
end
