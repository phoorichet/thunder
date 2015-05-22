class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :plan_type
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
