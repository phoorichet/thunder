class Insurance < ActiveRecord::Base
	has_many :contracts
	has_many :premiums
	has_many :coverages
	
	belongs_to :master_insurance
end
