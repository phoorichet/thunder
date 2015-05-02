class MainInsurance < ActiveRecord::Base
	has_many :premia
	has_many :coverages
	has_many :contracts
end
