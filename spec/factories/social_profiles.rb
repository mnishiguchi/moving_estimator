# == Schema Information
#
# Table name: social_profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  provider    :string
#  uid         :string
#  name        :string
#  nickname    :string
#  email       :string
#  url         :string
#  image_url   :string
#  description :string
#  other       :text
#  credentials :text
#  raw_info    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :social_profile do
    user nil
provider "MyString"
uid "MyString"
name "MyString"
nickname "MyString"
email "MyString"
url "MyString"
image_url "MyString"
description "MyString"
other "MyText"
credentials "MyText"
raw_info "MyText"
  end

end
