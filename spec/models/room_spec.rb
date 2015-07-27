# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { Room.new(name: "living room") }

  it { expect(room).to be_valid }
end
