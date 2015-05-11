class CreateMainPlans < ActiveRecord::Migration
  def change
    create_table :main_plans do |t|
      t.string :name
      t.string :description
      t.datetime :begin_at
      t.datetime :end_at
      t.string :status

      t.timestamps null: false
    end
  end
end
