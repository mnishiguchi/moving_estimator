# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#

class Todo < ActiveRecord::Base
  belongs_to :user

  before_save :downcase_input!  # Standardizes on all lower-case words.
  validates  :content, presence: true, uniqueness: false, length: { maximum: 50 }

  scope :sorted, ->{ order(updated_at: :desc) }

  def self.getInitialData
    User.current_user.todos.select(:id, :content, :completed, :created_at).sorted.to_json
  end

  private

    # Converts the input to all lower-case.
    def downcase_input!
      content.downcase!
    end
end
