class CreateMasterRiders < ActiveRecord::Migration
  def change
    create_table :master_riders do |t|
      t.string :name
      t.datetime :begin_at
      t.datetime :end_at
      t.string :description
      t.string :status
      t.string :code_name

      t.timestamps null: false
    end
  end
end
