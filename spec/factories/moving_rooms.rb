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
    moving_id 1
room_id 1
  end

end
