Factory.define :user do |user|
  user.name                     "Peter K"
  user.email                    "peter@example.com"
  user.password                 "foobar"
  user.password_confirmation    "foobar"
end 

Factory.sequence :email do |n|
   "person-#{n}@example.com"
end