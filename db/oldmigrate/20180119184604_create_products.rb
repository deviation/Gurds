class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      #t.integer :product_id null: false
      #t.text :brand null: false

      t.timestamps
    end
  end
end
