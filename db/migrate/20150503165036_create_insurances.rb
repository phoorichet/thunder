class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :name
      t.string :description
      t.string :begin_at
      t.string :end_at
      t.string :status
      t.integer :master_insurance_id

      t.timestamps null: false
    end
  end
end
