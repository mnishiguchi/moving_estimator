module MovingsHelper

  include RoomsHelper

  def remember_moving(moving)
    session[:moving_id] = moving.id
  end

  def forget_moving
    session.delete(:moving_id)
  end

  def current_moving
    session[:moving_id]
  end

  def us_states
    ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado",
      "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia",
      "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
      "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
      "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
      "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
      "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
      "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia",
      "Washington", "West Virginia", "Wisconsin", "Wyoming"]
  end

  # def rooms
  #   ["master bedroom", "bedroom 1", "bedroom 2", "bedroom 3", "bedroom 4",
  #     "dining room", "kitchen", "family room", "living room", "sun room",
  #     "basement", "media room", "patio", "garage", "outdoor playset", "shed"]
  # end

  def dwelling_types
    ["single home", "apartment", "townhouse", "office", "others"]
  end

  def move_types
    ["local", "long distance", "international"]
  end

end
