class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :village
      t.string :road
      t.string :subdistrict
      t.string :district
      t.string :province
      t.string :postal_code
      t.string :country
      t.integer :insure_user_id

      t.timestamps null: false
    end
  end
end
