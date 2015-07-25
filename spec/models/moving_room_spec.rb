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
  pending "add some examples to (or delete) #{__FILE__}"
end
