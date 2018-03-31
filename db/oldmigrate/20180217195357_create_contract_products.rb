class CreateContractProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :contract_products do |t|

      t.timestamps
    end
  end
end
