# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

include MovingsHelper
include IngredientsHelper

# make an admin user

admin = User.create!(
  username:     "Masa Nishiguchi",
  email:        "masatoshi.nishiguchi@udc.edu",
  confirmed_at: Time.zone.now,
  password:     "longpassword"
)
admin.toggle!(:admin)

# make sample users

66.times do |n|
  User.create!(
    username:     Faker::Name.name,
    email:        "example-#{n+1}@example.com",
    confirmed_at: Time.zone.now,
    password:     "longpassword"
  )
end

# make movings on a few users

users = User.take(3)
users.each do |user|
  n = (1..10).to_a.sample
  n.times do
    moving = user.movings.create!(
      title:         "from #{Faker::Address.city} to #{Faker::Address.city}",
      description:   Faker::Hacker.say_something_smart,
      move_type:     move_types.sample,
      move_date:     Time.zone.now,
      dwelling_sqft: Faker::Number.between(100, 900) + [0, 50].sample,
      dwelling_type: dwelling_types.sample,
      street_from:   Faker::Address.street_address,
      city_from:     Faker::Address.city,
      state_from:    Faker::Address.state,
      zip_from:      Faker::Address.zip,
      street_to:     Faker::Address.street_address,
      city_to:       Faker::Address.city,
      state_to:      Faker::Address.state,
      zip_to:        Faker::Address.zip
    )

    n = (1..30).to_a.sample
    n.times do
      moving.moving_items.create!(
        name:        Faker::Commerce.product_name,
        volume:      Faker::Number.between(1, 10) + [0, 0.5].sample,
        quantity:    Faker::Number.between(1, 10),
        room:        rooms.sample,
        category:    %w(a b c).sample,
        description: Faker::Lorem.sentence(6)
      )
    end
  end
end

# make rooms

rooms.each { |room| Room.create!(name: room) }

# make movings-rooms relationship

users.each do |user|
  user.movings.each do |m|
    (1..16).to_a.sample(5).each do |room_id|
      m.moving_rooms.create(moving_id: m.id, room_id: room_id)
    end
  end
end

# make item names suggestions(ingredients)

[living_room, kitchen, bedroom, dining_room, outdoor, office].each do |household_goods|
  household_goods.each { |name, volume| Ingredient.create!(name: name, volume: volume) }
end
