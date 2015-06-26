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

class Moving < ActiveRecord::Base
  belongs_to :user
  has_many :moving_items, dependent: :destroy

  # TODO - validation
end
