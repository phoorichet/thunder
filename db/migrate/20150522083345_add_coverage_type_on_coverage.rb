class AddCoverageTypeOnCoverage < ActiveRecord::Migration
  def change
      add_column :coverages, :coverage_type, :string
  end
end
