# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: 'Scott',
             email: 'scott@quandl.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true)
100.times do
  name = Faker::Name.name
  email = Faker::Internet.email name
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
