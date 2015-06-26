# == Schema Information
#
# Table name: movings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  categories  :text             default([]), is an Array
#  rooms       :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Moving, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
