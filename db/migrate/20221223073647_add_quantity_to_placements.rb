class AddQuantityToPlacements < ActiveRecord::Migration[7.0]
  def change
    add_column :placements, :quantity, :integer
  end
end
