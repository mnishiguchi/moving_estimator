# == Schema Information
#
# Table name: moving_rooms
#
#  id         :integer          not null, primary key
#  moving_id  :integer
#  room_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :moving_room do
    moving_id Faker::Number.between(1, 10)
    room_id   Faker::Number.between(1, 10)
  end

end
