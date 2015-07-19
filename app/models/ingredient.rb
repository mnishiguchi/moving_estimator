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

  before_save :downcase_name  # Standardizes on all lower-case words.

  validates  :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates  :volume, presence: true, length: { maximum: 5 }, numericality: true  #<= float

  scope :sorted, ->{ order(name: :asc) }
  scope :named, ->(q) { where("name ILIKE :name OR volume = :volume", name: "%#{q}%", volume: q) }

  private

    def downcase_name
      name.downcase!
    end
end
