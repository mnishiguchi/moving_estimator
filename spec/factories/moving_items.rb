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
    name        Faker::Commerce.product_name
    volume      Faker::Number.decimal(1, 1)
    quantity    Faker::Number.between(1, 10)
    room        "living room"
    category    Faker::Lorem.word
    description Faker::Commerce.department(2, true)
    moving
  end
end
