class RenameCoverageAmountToAssuredAmount < ActiveRecord::Migration
  def change
      rename_column :coverages, :coverage_amount, :assured_amount
  end
end
