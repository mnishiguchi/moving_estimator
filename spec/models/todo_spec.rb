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

require 'rails_helper'

RSpec.describe Todo, type: :model do

  let(:todo) do
    Todo.new(content: "Have a break",
             user_id: "123" )
  end

  it { expect(todo).to be_valid }
  it { expect(todo).not_to be_completed }

  it "has non-blank content" do
    todo.content = "  "
    expect(todo).not_to be_valid
    expect(todo).not_to have_error_message
  end

  it "has content with at most 50 characters" do
    todo.content = "a" * 51
    expect(todo).not_to be_valid
    expect(todo).not_to have_error_message
  end
end
