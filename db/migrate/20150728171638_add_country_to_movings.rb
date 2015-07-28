class AddCountryToMovings < ActiveRecord::Migration
  def change
    add_column :movings, :country_from, :string
    add_column :movings, :country_to, :string
  end
end
