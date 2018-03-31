class CreateCustomernotes < ActiveRecord::Migration[5.1]
  def change
    create_table :customernotes do |t|

      t.timestamps
    end
  end
end
