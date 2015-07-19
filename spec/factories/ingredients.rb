# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  volume     :float
#

FactoryGirl.define do
  factory :ingredient do
    name "laptop"
    volume 3.3
  end
end
