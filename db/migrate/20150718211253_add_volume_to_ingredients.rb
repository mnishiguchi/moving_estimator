class AddVolumeToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :volume, :float
  end
end
