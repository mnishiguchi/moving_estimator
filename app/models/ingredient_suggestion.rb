# == Schema Information
#
# Table name: ingredient_suggestions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IngredientSuggestion < ActiveRecord::Base
  scope :sorted, ->{ order(name: :asc) }
end
