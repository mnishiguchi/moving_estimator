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

require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  let(:ingredient) { FactoryGirl.create(:ingredient) }

  it { expect(ingredient).to be_valid }

  it "has a valid name" do
    is_expected.to validate_presence_of :name
    is_expected.to validate_uniqueness_of :name
    is_expected.to validate_length_of :name
  end

  it "has a valid volume" do
    is_expected.to validate_presence_of :volume
    is_expected.to validate_length_of :volume
    is_expected.to validate_numericality_of :volume
  end
end
