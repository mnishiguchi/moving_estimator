class Room < ActiveRecord::Base
  scope :sorted, ->{ order(name: :asc) }
  before_save :downcase_input!  # Standardizes on all lower-case words.
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

  private

    # Converts the input to all lower-case.
    def downcase_input!
      name.downcase!
    end
end
