class CreateMasterInsurances < ActiveRecord::Migration
  def change
    create_table :master_insurances do |t|
      t.string :name
      t.string :description
      t.string :begin_at
      t.string :end_at
      t.string :status

      t.timestamps null: false
    end
  end
end
