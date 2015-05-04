class MasterRider < ActiveRecord::Base
	has_many :riders
	has_many :premiums
	has_many :coverages
end
