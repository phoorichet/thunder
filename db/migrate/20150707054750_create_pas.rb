class CreatePas < ActiveRecord::Migration
  def change
    create_table :pas do |t|
      t.string :name
      t.string :status
      t.integer :book_id
      t.string :pa_type
      t.integer :reference_id
      t.text :description

      t.timestamps null: false
    end
  end
end
