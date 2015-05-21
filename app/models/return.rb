class Return < ActiveRecord::Base
	belongs_to :master_coverage
	belongs_to :coverage
end
