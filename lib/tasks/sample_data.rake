# $random_volume   = Faker::Number.between(1, 10) + [0, 0.5].sample
# $categories      = %w(ocean air local disposal)
# $rooms           = ["living room", "dining room", "bedroom", "kitchen", "bathroom"]
# $household_goods = ["bed", "sofa", "sofa(2-seat)", "sofa(3-seat)", "sofa(4-seat)", "bunk_bed", "sofa_bed", "footstool", "rocking_chair", "chair", "accent_chair", "accent_chest", "accent_table", "audio_rack", "ottoman", "cd_dvd_media_storage", "tv_stand", "electric_fireplace", "bean_bag", "stool", "bench", "couch", "futon", "hammock", "headboard", "crib", "cradle", "infant_bed", "mattress", "billiard_table", "chess_table", "entertainment_center", "television_set", "radio", "video_game_console", "storage_box", "desk", "computer_desk", "writing_desk", "kotatsu", "coffee_table", "dining_table", "end_table", "folding_table", "bookcase", "kitchen_cabinet", "cupboard", "chest", "drawer", "nightstand", "shelving", "sideboard", "wordrobe", "armoires", "bed_frames", "wine_rack", "dresser", "plastic_furniture", "folding_chair", "high_chair", "mirror", "bakers_rack", "bar_stool", "dining_chair", "kitchen_cart", "microwave_stand", "toy", "office_chair", "magazine_rack", "outdoor_chair", "outdoor_bench", "outdoor_rocking_chair", "outdoor_sofa", "outdoor_coffeetable", "patio_dining_table", "side_table", "wall_shelf", "dressing_table", "small_moving_box", "medium_moving_box", "large_moving_box", "personal_computer", "audio_player", "speaker", "printer", "clothing_rack", "picture_frame", "christmas_tree", "books/documents", "microwave", "sewing_machine", "vacuum_cleaner", "king_bed", "queen_bed", "double_bed", "single_bed", "bookshelf(small)", "bookshelf(medium)", "bookshelf(large)", "comforter/blanket", "electronic_piano", "upright_piano", "grand_piano", "golf_set", "ski_set", "bicycle(small)", "bycycle(large)", "suitcase(small)", "suitcase(large)", "carpet/rug", "cookware(medium_box)", "kitchen_appliances(medium_box)"]

# namespace :db do
#   desc "Fill database with sample data"
#   task populate: :environment do
#     make_users
#     make_movings
#     make_rooms
#     make_ingredients
#   end
# end

# def make_users
#   admin = User.create!(username:     "Masa Nishiguchi",
#                        email:        "nishiguchi.masa@gmail.com",
#                        confirmed_at: Time.zone.now,
#                        password:     "longpassword" )
#   admin.toggle!(:admin)

#   99.times do |n|
#     name     = Faker::Name.name
#     email    = "example-#{n+1}@example.com"
#     password = "longpassword"
#     User.create!(username:     name,
#                  email:        email,
#                  confirmed_at: Time.zone.now,
#                  password:     password )
#   end
# end

# def make_movings
#   users = User.take(6)
#   users.each do |user|
#     n = (1..10).to_a.sample
#     n.times do
#       title       = "from #{Faker::Address.city} to #{Faker::Address.city}"
#       description = Faker::Lorem.sentence(4)
#       moving      = user.movings.create!(title: title, description: description)

#       n = (1..50).to_a.sample
#       n.times do
#         name        = Faker::Commerce.product_name
#         volume      = $random_volume
#         quantity    = Faker::Number.between(1, 10)
#         room        = $rooms.sample
#         category    = $categories.sample
#         description = Faker::Lorem.sentence(4)
#         moving.moving_items.create!(name: name, volume: volume, quantity: quantity,
#                                     room: room, category: category, description: description)
#       end
#     end
#   end
# end

# def make_rooms
#   $rooms.each { |room| Room.create!(name: room) }
# end

# def make_ingredients
#   $household_goods.each { |name| Ingredient.create!(name: name, volume: $random_volume) }
# end
