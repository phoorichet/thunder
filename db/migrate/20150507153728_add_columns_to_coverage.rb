class AddColumnsToCoverage < ActiveRecord::Migration
  def change
      add_column :coverages, :abbr, :string
      add_column :coverages, :premium_amount, :float
      add_column :coverages, :premium_unit, :string
      add_column :coverages, :coverage_unit, :string
      add_column :coverages, :coverage_end_at, :string
      rename_column :coverages, :amount, :coverage_amount
  end
end
