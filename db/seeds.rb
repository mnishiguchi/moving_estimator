# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
User.create!(username:     "Example User",
             email:        "user@example.com",
             password:     "password",
             admin:        true,
             confirmed_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(username:     name,
               email:        email,
               password:     password,
               confirmed_at: Time.zone.now
              )
end

99.times do |n|
  name  = Faker::Commerce.product_name
  Ingredient.create!(name: name)
end

m = Moving.create!(user_id: 1, title: "My first moving", description: "It's gonnabe fun!",
  categories: ["ocean", "air", "disposal"], rooms: %w[entrance living dining kitchen bathroom bedroom])

10.times do |n|
  MovingItem.create!(moving_id: 1, name: "Medium box", volume: 3.2, quantity: 3, description: "",
    category: "ocean", room: "kitchen")
end
