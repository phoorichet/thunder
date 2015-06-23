class CreateSurrenders < ActiveRecord::Migration
  def change
    create_table :surrenders do |t|
      t.string :surrender_type
      t.integer :year
      t.integer :assured_age
      t.string :cv
      t.string :rpu
      t.string :ecv
      t.string :eti
      t.integer :eti_year
      t.integer :eti_day
      t.string :etipe
	  t.integer :insurance_id

      t.timestamps null: false
    end
  end
end
