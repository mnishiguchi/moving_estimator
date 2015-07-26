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

class MovingRoom < ActiveRecord::Base
  belongs_to :moving
  belongs_to :room

  validates :moving_id, presence: true
  validates :room_id, presence: true
end
