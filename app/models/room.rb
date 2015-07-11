class Room < ActiveRecord::Base
  scope :sorted, ->{ order(name: :asc) }
end
