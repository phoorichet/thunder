class MasterInsurance < ActiveRecord::Base
	has_many :insurances
	has_many :premiums
	has_many :coverages
end
