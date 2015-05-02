class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :insured_user_id
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
