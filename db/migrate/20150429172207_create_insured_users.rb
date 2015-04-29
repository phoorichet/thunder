class CreateInsuredUsers < ActiveRecord::Migration
  def change
    create_table :insured_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.datetime :birthdate
      t.string :marital_status

      t.timestamps null: false
    end
  end
end
