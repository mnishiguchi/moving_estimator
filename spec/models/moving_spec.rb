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

require 'rails_helper'

RSpec.describe Moving, type: :model do
  let(:moving) { FactoryGirl.create(:moving) }

  it { expect(moving).to be_valid }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.not_to validate_presence_of :description }

  it { is_expected.to validate_length_of :title }
  it { is_expected.to validate_length_of :description }
end
