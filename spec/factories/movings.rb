# == Schema Information
#
# Table name: movings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  categories  :text             default([]), is an Array
#  rooms       :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :moving do
    user nil
    title "MyString"
    description "MyText"
    categories "MyString"
    rooms "MyString"
  end

end
