class Rider < ActiveRecord::Base
	has_many :coverages, :dependent => :destroy
	belongs_to :plan

	scope :master, ->(){ where(rider_type: 'master')}

	def is_master?
		self.rider_type == 'master'
	end
end
