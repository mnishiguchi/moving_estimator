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
  validates  :content, presence: true, uniqueness: false, length: { maximum: 50 }

  def self.getInitialData
    User.current_user.todos.select(:id, :content, :completed, :created_at).to_json
  end
end
