class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :name
      t.float :amount
      t.float :premium
      t.integer :protection_length
      t.integer :paid_preriod_length
      t.string :consider_yeader
      t.string :consider_gender
      t.string :company
      t.integer :reference_id
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
