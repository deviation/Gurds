class CreateCustomerContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_contacts do |t|

      t.timestamps
    end
  end
end
