# == Schema Information
#
# Table name: moving_items
#
#  id          :integer          not null, primary key
#  moving_id   :integer
#  name        :string
#  volume      :float
#  quantity    :integer
#  description :text
#  room        :text
#  category    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MovingItem < ActiveRecord::Base
  belongs_to :moving

  before_save :downcase_input!  # Standardizes on all lower-case words.

  validates :name,        presence: true,  length: { maximum: 50 }
  validates :volume,      presence: true,  length: { maximum: 5 }, numericality: true  #<= float
  validates :quantity,    presence: true,  length: { maximum: 5 }, numericality: { only_integer: true }
  validates :room,        presence: true,  length: { maximum: 50 }
  validates :category,    presence: true,  length: { maximum: 50 }
  validates :description, presence: false, length: { maximum: 200 }

  class << self

    def to_csv(options = {})  # e.g., headers
      attributes = %w(name volume quantity room category description)
      moving = first.moving

      CSV.generate(options) do |csv|
        csv << [ Time.zone.now.getlocal ]
        csv << [ moving.title ]
        csv << [ moving.description ]
        csv << []
        csv << attributes
        all.each do |item|
          csv << attributes.map{ |attr| item.send(attr) }
        end
      end
    end
  end

  private

    # Converts the input to all lower-case.
    def downcase_input!
      name.downcase!
      room.downcase!
      category.downcase!
    end
end
