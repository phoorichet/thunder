class CreatePackagePlans < ActiveRecord::Migration
  def change
    create_table :package_plans do |t|
      t.string :name
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :rider_id

      t.timestamps null: false
    end
  end
end
