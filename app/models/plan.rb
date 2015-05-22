class Plan < ActiveRecord::Base
	belongs_to :book
	has_many :riders, :dependent => :destroy

	scope :master, ->(){ where(plan_type: 'master')}

	def is_master?
		self.plan_type == 'master'
	end
end
