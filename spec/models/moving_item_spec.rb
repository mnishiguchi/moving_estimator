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

require 'rails_helper'

RSpec.describe MovingItem, type: :model do

  let(:moving_item) { FactoryGirl.create(:moving_item) }

  it { expect(moving_item).to be_valid }

  it "validates presence" do
    is_expected.to validate_presence_of :name
    is_expected.to validate_presence_of :volume
    is_expected.to validate_presence_of :quantity
    is_expected.to validate_presence_of :room
    is_expected.to validate_presence_of :category
    is_expected.not_to validate_presence_of :description
  end

  it "validates length" do
    is_expected.to validate_length_of :name
    is_expected.to validate_length_of :volume
    is_expected.to validate_length_of :quantity
    is_expected.to validate_length_of :room
    is_expected.to validate_length_of :category
    is_expected.to validate_length_of :description
  end

  it "validates numericality" do
    is_expected.to validate_numericality_of :volume
    is_expected.to validate_numericality_of :quantity
  end

  context "with an empty name" do
    before { moving_item.update_attribute(:name, "") }
    it { is_expected.not_to be_valid }
  end

  context "with a lowercase name" do
    before { moving_item.update_attribute(:name, "Upcase name") }
    it { is_expected.not_to be_valid }
  end

  context "with a lowercase room" do
    before { moving_item.update_attribute(:room, "uPcase room") }
    it { is_expected.not_to be_valid }
  end

  context "with a lowercase category" do
    before { moving_item.update_attribute(:category, "upCase category") }
    it { is_expected.not_to be_valid }
  end
end
