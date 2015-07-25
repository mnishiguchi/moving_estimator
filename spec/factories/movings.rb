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

# http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md#Associations

FactoryGirl.define do
  factory :moving do
    title       "title"
    description "description"
    user
    # association :user, factory: :user
  end
end
