class ChangeDescriptionTypeOnCoverage < ActiveRecord::Migration
  def change
      remove_column :coverages, :description
      add_column :coverages, :description, :text
  end
end
