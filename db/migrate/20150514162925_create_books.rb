class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :insured_user_id
      t.datetime :begin_at
      t.datetime :end_at
      t.string :number
      t.integer :main_rider_id

      t.timestamps null: false
    end
  end
end
