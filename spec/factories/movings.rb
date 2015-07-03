# == Schema Information
#
# Table name: movings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md#Associations

FactoryGirl.define do
  factory :moving do
    title       "title"
    description "description"

    association :user, factory: :user
  end
end
