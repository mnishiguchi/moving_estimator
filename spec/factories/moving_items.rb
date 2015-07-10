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

FactoryGirl.define do
  factory :moving_item do
    name        "macbook"
    volume      3.0
    quantity    1
    room        "living room"
    category    "local"
    description "high value"
    moving
  end
end
