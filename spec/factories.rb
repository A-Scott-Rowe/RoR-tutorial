FactoryGirl.define do
  factory :user do
    name 'John'
    email 'Doe@email.com'
    password 'password'
    activated true
    activated_at Time.now.utc
  end
end
