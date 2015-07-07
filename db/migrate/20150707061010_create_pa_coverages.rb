class CreatePaCoverages < ActiveRecord::Migration
  def change
    create_table :pa_coverages do |t|
      t.string :key
      t.integer :pa_id
      t.text :description
      t.string :coverage_type
      t.integer :reference_id
      t.string :value

      t.timestamps null: false
    end
  end
end
