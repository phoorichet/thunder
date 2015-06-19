class CreateReturns < ActiveRecord::Migration
  def change
    create_table :returns do |t|
      t.integer :year
      t.integer :age
      t.float :amount

      t.timestamps null: false
    end
  end
end
