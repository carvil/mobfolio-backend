FactoryGirl.define do
  factory :user do
    email 'carlos@me.com'
    password 'password'
    password_confirmation 'password'
  end
end
