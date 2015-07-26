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

  def save_rooms(room_ids)
    reject_empty_options!(room_ids)
    forgetAllRooms
    rememberRooms(room_ids)
  end

  private

    # Return true if rooms are successfully saved; else false.
    def rememberRooms(room_ids)
      room_ids.each do |room_id|
        result = MovingRoom.create(moving_id: self.id, room_id: room_id)
        return false if result.errors.any?
      end
      true
    end

    def forgetAllRooms
      MovingRoom.where(moving_id: self.id).destroy_all
    end

    # hiddenタグによって生成される空文字のcodeを除去する
    def reject_empty_options!(room_ids)
      room_ids.reject!(&:empty?)
    end
end
