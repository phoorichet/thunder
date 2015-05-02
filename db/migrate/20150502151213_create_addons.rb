class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|
      t.integer :contract_id
      t.integer :rider_id

      t.timestamps null: false
    end
  end
end
