# == Schema Information
#
# Table name: movings
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  title         :string
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  move_type     :string
#  move_date     :date
#  dwelling_sqft :integer
#  dwelling_type :string
#  street_from   :string
#  city_from     :string
#  state_from    :string
#  zip_from      :string
#  street_to     :string
#  city_to       :string
#  state_to      :string
#  zip_to        :string
#

class Moving < ActiveRecord::Base

  belongs_to :user
  has_many :moving_items, dependent: :destroy

  has_many :moving_rooms, dependent: :destroy  # a join table
  has_many :rooms, through: :moving_rooms

  validates :title,       presence: true,  length: { maximum: 50 }
  validates :description, presence: false, length: { maximum: 255 }

  # TODO - update validations

  def add_room(room)
    rooms.create(moving_id: self.id, room_id: room.id)
  end

  def delete_room(room)
    rooms = rooms.find_by(moving_id: self.id, room_id: room.id)
    rooms.destroy
  end
end
