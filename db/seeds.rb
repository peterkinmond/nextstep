# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create 2 users, each with a single project
user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
user.projects.create(name: 'Test Project')
project = user.projects.first
project.steps.create(content: 'Investigate legality of project', estimated_time: 40)

user2 = User.create(name: 'Test User2', email: 'test2@example.com', password: 'password')
user2.projects.create(name: 'Test Project2')
project2 = user2.projects.first
project2.steps.create(content: 'Test step for project 2', estimated_time: 30)
