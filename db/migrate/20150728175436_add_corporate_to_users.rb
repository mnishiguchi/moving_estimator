class AddCorporateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :corporate, :boolean, default: false
    add_column :users, :mover_url, :string
  end
end
