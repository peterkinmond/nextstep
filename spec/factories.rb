FactoryGirl.define do
  factory :user do
    name "Peter K"
    email "peter@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person-#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :project do
    name "My new project"
    association :user
  end
end

FactoryGirl.define do
  factory :step do
    content "This is a step"
    estimated_time 10
    project_id 1
    association :user
  end
end