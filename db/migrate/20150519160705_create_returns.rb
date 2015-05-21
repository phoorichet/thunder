class CreateReturns < ActiveRecord::Migration
  def change
    create_table :returns do |t|
      t.string :return_type
      t.float :amount
      t.integer :relative_year
      t.integer :coverage_id

      t.timestamps null: false
    end
  end
end
