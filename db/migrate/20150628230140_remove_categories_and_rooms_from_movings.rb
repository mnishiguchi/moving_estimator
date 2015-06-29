# == Schema Information
#
# Table name: movings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  categories  :text             default([]), is an Array
#  rooms       :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Read: http://edgeguides.rubyonrails.org/active_record_migrations.html#using-the-change-method
# remove_column is reversible if you supply the column type as the third argument.
# Provide the original column options too, otherwise Rails can't recreate the column exactly when rolling back.
class RemoveCategoriesAndRoomsFromMovings < ActiveRecord::Migration
  def change
    remove_column :movings, :categories, :text, array: true, default: []
    remove_column :movings, :rooms,      :text, array: true, default: []
  end
end
