class CreateMasterCoverages < ActiveRecord::Migration
  def change
    create_table :master_coverages do |t|
      t.string :name
      t.string :description
      t.float :coverage_amount
      t.string :category
      t.integer :master_rider_id
      t.string :abbr
      t.float :premium_amount
      t.string :premium_unit
      t.string :coverage_unit
      t.string :coverage_end_at

      t.timestamps null: false
    end
  end
end
