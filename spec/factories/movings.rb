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
#  country_from  :string
#  country_to    :string
#

# http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md#Associations

FactoryGirl.define do
  factory :moving do
    title         "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
    description   Faker::Hacker.say_something_smart
    move_type     "international"
    move_date     Time.zone.now
    dwelling_sqft 999
    dwelling_type "apartment"
    street_from   Faker::Address.street_address
    city_from     Faker::Address.city
    state_from    Faker::Address.state
    zip_from      Faker::Address.zip
    street_to     Faker::Address.street_address
    city_to       Faker::Address.city
    state_to      Faker::Address.state
    zip_to        Faker::Address.zip
    user
    # association :user, factory: :user
  end
end
