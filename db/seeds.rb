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

# Adds 50 sample items to the first 6 users.
users = User.order(:created_at).take(6)
users.each do |user|
  user.movings.create!(title: "from #{Faker::Address.city} to #{Faker::Address.city}")
end

categories = %w(ocean air local disposal)
rooms      = ["living room", "dining room", "bedroom", "kitchen", "bathroom")

50.times do
  users.each do |user|
    moving = user.movings.first
    moving.moving_items.create!(
      name:        Faker::Commerce.product_name,
      volume:      3,
      quantity:    1,
      room:        rooms.sample,
      category:    categories.sample,
      description: Faker::Lorem.sentence)
  end
end

# Ingredients
volume_values = (2..10).to_a
99.times do |n|
  name  = Faker::Commerce.product_name
  Ingredient.create!(name: name, volume: volume_values.sample)
end



