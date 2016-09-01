FactoryGirl.define do
  factory :micropost do
    content 'I just ate an orange!'
    user nil
  end

  factory :user do
    name 'John'
    email 'Doe@email.com'
    password 'password'
    activated true
    activated_at Time.now.utc
  end
end
