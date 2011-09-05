Factory.define :user do |user|
  user.name                     "Peter K"
  user.email                    "peter@example.com"
  user.password                 "foobar"
  user.password_confirmation    "foobar"
end 

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :project do |project|
   project.name               "My new project"
   project.association        :user
end

Factory.define :step do |step|
  step.content                "This is a step"
  step.estimated_time         10
  step.project_id             1    
  step.association            :user
end