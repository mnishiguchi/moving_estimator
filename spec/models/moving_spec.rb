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

require 'rails_helper'

RSpec.describe Moving, type: :model do
  let(:moving) { FactoryGirl.create(:moving) }

  it { expect(moving).to be_valid }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.not_to validate_presence_of :description }

  it { is_expected.to validate_length_of :title }
  it { is_expected.to validate_length_of :description }
end
