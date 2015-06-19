class RenamDividentoAmountOnDividend < ActiveRecord::Migration
  def change
	  rename_column :dividends, :dividend, :amount
  end
end
