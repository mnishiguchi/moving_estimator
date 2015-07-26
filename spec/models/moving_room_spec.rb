# == Schema Information
#
# Table name: moving_rooms
#
#  id         :integer          not null, primary key
#  moving_id  :integer
#  room_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe MovingRoom, type: :model do
  let(:moving_room) do
    m = FactoryGirl.create(:moving)
    r = FactoryGirl.create(:room)
    m.moving_rooms.create(moving_id: m.id, room_id: r.id)
  end

  it { expect(moving_room).to be_valid }

  it { is_expected.to validate_presence_of :moving_id }
  it { is_expected.to validate_presence_of :room_id }
end
