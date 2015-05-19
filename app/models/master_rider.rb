class MasterRider < ActiveRecord::Base
	has_many :master_coverages, :dependent => :destroy
end
