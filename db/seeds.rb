# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

include RoomsHelper
rooms = RoomsHelper::rooms

categories      = %w(ocean air local disposal)

# make_users

admin = User.create!(username:     "Masa Nishiguchi",
                     email:        "nishiguchi.masa@gmail.com",
                     confirmed_at: Time.zone.now,
                     password:     "longpassword" )
admin.toggle!(:admin)

99.times do |n|
  name     = Faker::Name.name
  email    = "example-#{n+1}@example.com"
  password = "longpassword"
  User.create!(username:     name,
               email:        email,
               confirmed_at: Time.zone.now,
               password:     password )
end

# make_movings

users = User.take(6)
users.each do |user|
  n = (1..10).to_a.sample
  n.times do
    title       = "from #{Faker::Address.city} to #{Faker::Address.city}"
    description = Faker::Lorem.sentence(6)
    moving      = user.movings.create!(title: title, description: description)

    n = (1..50).to_a.sample
    n.times do
      name        = Faker::Commerce.product_name
      volume      = Faker::Number.between(1, 10) + [0, 0.5].sample
      quantity    = Faker::Number.between(1, 10)
      room        = rooms.sample
      category    = categories.sample
      description = Faker::Lorem.sentence(6)
      moving.moving_items.create!(name: name, volume: volume, quantity: quantity,
                                  room: room, category: category, description: description)
    end
  end
end

# make_rooms

rooms.each { |room| Room.create!(name: room) }
