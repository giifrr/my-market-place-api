class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :price, default: 0, null: false
      t.string :name, null: false
      t.text :description
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
