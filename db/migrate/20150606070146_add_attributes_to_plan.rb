class AddAttributesToPlan < ActiveRecord::Migration
  def change
  	# Example
		# "minimumAge": 0,
		# "maximumAge": 70,
		# "considerYear": "year",
		# "considerGender": "both",
		# "haveSurrender": true,
		# "haveDividend": true,                         
		# "paidPeriodLength": 15,
		# "protectionLength": 25,
		# "group": "saving",
		# "company": "AIA"
		add_column :plans, :minimum_age, :integer
		add_column :plans, :maximum_age, :integer
		add_column :plans, :consider_year, :string
		add_column :plans, :consider_gender, :string
		add_column :plans, :have_surrender, :boolean
		add_column :plans, :have_dividend, :boolean
		add_column :plans, :paid_preriod_length, :integer
		add_column :plans, :protection_length, :integer
		add_column :plans, :group, :string
		add_column :plans, :company, :string
  end
end
