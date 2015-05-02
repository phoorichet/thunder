class MainInsurance < ActiveRecord::Base
	has_many :premia
	has_many :coverages
end
