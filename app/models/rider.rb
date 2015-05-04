class Rider < ActiveRecord::Base
	has_many :premiums
	has_many :coverages

	belongs_to :master_rider
	belongs_to :contracts
end
