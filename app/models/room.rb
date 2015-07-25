# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ActiveRecord::Base

  has_many :moving_rooms, dependent: :destroy  # a join table
  has_many :movings, through: :moving_rooms

  scope :sorted, ->{ order(name: :asc) }
  before_save :downcase_input!  # Standardizes on all lower-case words.
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  private

    # Converts the input to all lower-case.
    def downcase_input!
      name.downcase!
    end
end
