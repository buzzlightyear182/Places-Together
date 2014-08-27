FactoryGirl.define do
  factory :user, aliases: [:organizer] do
    username "testuser"
    email "testuser@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
