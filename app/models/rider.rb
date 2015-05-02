class Rider < ActiveRecord::Base
	has_many :premia
	has_many :coverages

	has_many :addons
	has_many :contracts, through: :addons 
end
