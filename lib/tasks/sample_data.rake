namespace :db do
  desc "Fill ingredients table with sample data"
  task populate_ingredients: :environment do
    make_ingredients(living_room)
    make_ingredients(kitchen)
    make_ingredients(bedroom)
    make_ingredients(dining_room)
    make_ingredients(outdoor)
    make_ingredients(office)
  end
end

def make_ingredients(household_goods)
  household_goods.each { |name, volume| Ingredient.create!(name: name, volume: volume) }
end

def living_room
  {
    "armchair, small" => 20,
    "armchair, large" => 30,
    "sofa, 4 seater" => 70,
    "sofa, 3 seater" => 60,
    "sofa, 2 seater" => 40,
    "sofa bed" => 50,
    "sofa sectional (per section)" => 30,
    "ottoman" => 8,
    "occasional chair" => 15,
    "lazy boy" =>  25,
    "book case" => 20,
    "pictures" => 5,
    "coffee tables" => 5,
    "end table" => 5,
    "wall unit, small" => 15,
    "wall unit ,large" => 20,
    "cupboard, small" => 10,
    "cupboard,  large" => 15,
    "bureau" => 20,
    "tv" => 25,
    "tv stand" => 10,
    "entertainment_center" => 40,
    "cd_dvd_media_storage" => 10,
    "tv_stand" => 15,
    "electric_fireplace" => 20,
    "video" => 5,
    "stereo, mid" => 15,
    "stereo, large" => 20,
    "cd dvd media storage" => 10,
    "floor lamps" => 3,
    "curtain" => 10,
    "upright piano" => 60,
    "baby grand piano" => 70,
    "grand piano" => 80,
    "carpet & Rug" => 10,
    "clock grand father" => 20,
    "accent chair" => 10,
    "accent chest" => 15,
    "accent table" => 10,
    "audio rack" => 10,
    "electric fireplace" => 20,
    "crib, cradle" => 20,
    "end_table" => 6,
    "folding_table" => 3,
  }
end

def kitchen
  {
    "breakfast chair" => 5,
    "breakfast table" => 10,
    "chair, high" => 5,
    "kitchen cabinet" => 30,
    "serving cart" => 15,
    "utility cabinet" => 10,
    "refrigerator, small" => 40,
    "refrigerator, medium" => 45,
    "refrigerator, larger" => 55,
    "freezer, small" => 45,
    "freezer, medium" => 50,
    "freezer, large" => 60,
    "washing machine" => 35,
    "dryer" => 25,
    "stove" => 30,
    "dishwasher" => 35,
    "microwave" => 10,
    "glasses(medium_box)" => 3,
    "dishes(medium_box)" => 3,
    "kitchen_appliances(medium_box)" => 3,
    "cookware(medium_box)" => 3,
    "vacuum cleaner" => 5,
  }
end

def bedroom
  {
    "king bed" => 70,
    "queen bed" => 55,
    "single bed" => 40,
    "bunk bed(set of 2)" => 70,
    "dresser" => 30,
    "chest of drawers" => 30,
    "shelving" => 8,
    "sideboard" => 27,
    "wordrobe_cabinet" => 36,
    "armoires" => 36,
    "ironing board" => 10,
    "night stand" => 6,
    "side tables" => 10,
    "wardrobe boxes(30 hangers)" => 10,
    "mirror" => 10,
  }
end

def dining_room
    {
      "buffet" =>  30,
      "dining table, small" =>  20,
      "dining table, medium" =>  25,
      "dining table, glass" => 30,
      "dining table, large" => 30,
      "dining chair" => 6,
      "china cabinet" => 25,
      "corner cabinet" =>  20,
    }
end

def outdoor
    {
      "barbecue grill" => 10,
      "chair, lawn"  => 5,
      "chair, porch" =>  10,
      "ladder, extension" => 10,
      "lawn mower" => 35,
      "outdoor swings" =>  30,
      "picnic table" =>  20,
      "golf_set" => 5,
      "ski_set" => 5,
      "bicycle, small" => 15,
      "bycycle, large" => 27,
      "moving boxes, small" => 1.5,
      "moving boxes, medium" => 3,
      "moving boxes, large" => 4.5,
      "moving boxes, extra large" => 6,
    }
end

def office
    {
      "bench" => 25,
      "bookcase, small" => 10,
      "bookcase, medium"  => 15,
      "bookcase, large" =>  20,
      "cabinet" => 25,
      "cabinet, metal small" => 20,
      "chair, arm" => 10,
      "safe" => 50,
      "shelf, metal small" => 5,
      "shelving, industrial" => 8,
      "chair, stackable" => 3,
      "chair, upholstered"  =>  30,
      "chair, folding"   => 2,
      "coat rack"  => 2,
      "computer desk"  => 20,
      "copier stand"  =>  2,
      "credenza"   => 50,
      "desk, executive" =>  40,
      "desk, secretary"  => 35,
      "file 2 drawer" =>  20,
      "file 3 drawer" =>  23,
      "file 4 drawer"  => 26,
      "file 5 drawer"  => 29,
      "showcase"  =>  35,
      "stool"  => 3,
      "table"  => 12,
      "table, coffee"   => 5,
      "table, conference"  => 50,
      "table, drawing"   => 20,
      "table, end"   => 5,
      "table, folding" => 10,
    }
end
