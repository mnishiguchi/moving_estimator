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

class Moving < ActiveRecord::Base

  belongs_to :user
  has_many :moving_items, dependent: :destroy

  # TODO - format validation for categories and rooms

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # format: { with: VALID_EMAIL_REGEX }

  validates :title,       presence: true,  length: { maximum: 50 }
  validates :description, presence: false, length: { maximum: 255 }

end
