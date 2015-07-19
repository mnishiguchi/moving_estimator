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

class Ingredient < ActiveRecord::Base
  scope :sorted, ->{ order(name: :asc) }

  before_save :downcase_input!  # Standardizes on all lower-case words.

  validates  :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates  :volume, presence: true, length: { maximum: 5 }, numericality: true  #<= float

  private

    # Converts the input to all lower-case.
    def downcase_input!
      name.downcase!
    end
end
