class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.string :name
      t.datetime :begin_at
      t.datetime :end_at
      t.string :number
      t.string :description
      t.string :status
      t.string :rider_type

      t.timestamps null: false
    end
  end
end
