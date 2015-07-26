# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

rooms = [
  "Master Bedroom",
  "Bedroom 1",
  "Bedroom 2",
  "Bedroom 3",
  "Bedroom 4",
  "Dining Room",
  "Kitchen",
  "Family Room",
  "Living Room",
  "Sun Room",
  "Basement",
  "Media Room",
  "Patio",
  "Garage",
  "Outdoor Playset",
  "Shed"
]

FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| rooms[n] }
  end
end
