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

FactoryGirl.define do
  factory :todo do
    content "Pick up my wife from the train station"
    user
  end

end
