class Rider < ActiveRecord::Base
	has_many :coverages
	belongs_to :contract
end
