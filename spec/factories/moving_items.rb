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

# FactoryGirl.define do
#   factory :moving_item do
#     moving nil
# name "MyString"
# vol 1.5
# quantity 1
# description "MyText"
# room "MyText"
# category "MyText"
#   end

# end
