class CreatePersons < ActiveRecord::Migration
  def change
    create_table :persons do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.string :marital_status
      t.integer :spouse_id
      t.float :income
      t.string :national_id
      t.string :passport_id
      t.float :height
      t.float :weight
      t.string :occupation
      t.string :person_type
      t.string :accestry
      t.boolean :is_smoking

      t.timestamps null: false
    end

    add_index :persons, :accestry
  end
end
