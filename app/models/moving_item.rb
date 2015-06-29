# == Schema Information
#
# Table name: moving_items
#
#  id          :integer          not null, primary key
#  moving_id   :integer
#  name        :string
#  volume      :float
#  quantity    :integer
#  description :text
#  room        :text
#  category    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MovingItem < ActiveRecord::Base
  belongs_to :moving

  # TODO - format validation
  validates :name,        presence: true, length:  { maximum: 50 }
  validates :volume,      presence: true, length:  { maximum: 10 }  #<= float
  validates :quantity,    presence: true, length:  { maximum: 10 }  #<= int
  validates :room,        presence: true, length:  { maximum: 50 }
  validates :category,    presence: true, length:  { maximum: 50 }
  validates :description, presence: false, length: { maximum: 200 }
end
