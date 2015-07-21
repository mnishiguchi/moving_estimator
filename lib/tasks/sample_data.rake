namespace :db do
  desc "Fill database's ingredients table with sample data"
  task populate_ingredients: :environment do
    make_ingredients(household_goods)
  end
end

def make_ingredients(household_goods)
  household_goods.each { |name, volume| Ingredient.create!(name: name, volume: volume) }
end

def household_goods
  goods = %w[
    armchair(small) 20
    armchair(large) 30
    sofa(2-seat) 45
    sofa(3-seat) 60
    sofa(4-seat) 70
    bunk_bed 40
    sofa_bed 60
    footstool 8
    rocking_chair 30
    chair 8
    accent_chair 20
    accent_chest 15
    accent_table 10
    audio_rack 10
    ottoman 8
    cd_dvd_media_storage 10
    tv_stand 15
    electric_fireplace 20
    bean_bag 6
    stool 8
    bench 20
    crib 20
    cradle 20
    infant_bed 20
    entertainment_center 40
    television_set 8
    video_game_console 2
    storage_box 3
    desk 15
    coffee_table 6
    dining_table 10
    end_table 6
    folding_table 3
    kitchen_cabinet 30
    cupboard 30
    chest_of_drawers 15
    nightstand 8
    shelving 8
    sideboard 27
    wordrobe_cabinet 36
    armoires 36
    wine_rack 10
    dresser 20
    plastic_furniture 6
    folding_chair 3
    high_chair 6
    mirror 6
    bar_stool 8
    dining_chair 6
    kitchen_cart 10
    microwave_stand 10
    office_chair 20
    magazine_rack 5
    side_table 8
    wall_shelf 5
    small_moving_box 1.5
    medium_moving_box 3
    large_moving_box 4.5
    extra_large_moving_box 6
    desktop_computer 8
    laptop 3
    audio_player 3
    speaker 10
    printer 2
    clothing_rack 6
    picture_frame 3
    christmas_tree 8
    books/documents(small-box) 1.5
    microwave 6
    sewing_machine 3
    vacuum_cleaner 3
    king_bed 62
    queen_bed 42
    single_bed 30
    bookshelf(small) 10
    bookshelf(medium) 20
    bookshelf(large) 30
    electronic_piano 20
    upright_piano 45
    golf_set 5
    ski_set 5
    bicycle(small) 15
    bycycle(large) 27
    suitcase(small) 2
    suitcase(large) 5
    carpet/rug 5
    cookware(medium_box) 3
    kitchen_appliances(medium_box) 3
  ]
  goods.map { |w| w.gsub!(/_/, " ") }  # remove underscores
  goods = goods.each_slice(2).to_a     # array of key-value pairs
  goods = Hash[goods]                  # hash
end
