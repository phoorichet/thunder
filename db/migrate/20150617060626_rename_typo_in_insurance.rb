class RenameTypoInInsurance < ActiveRecord::Migration
  def change
	  rename_column :insurances, :paid_preriod_length, :paid_period_length
  end
end
