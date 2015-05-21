class RenameCoverageAmountOnCoverage < ActiveRecord::Migration
  def change
      rename_column :master_coverages, :coverage_amount, :assured_amount
  end
end
