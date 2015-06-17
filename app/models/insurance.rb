class Insurance < ActiveRecord::Base
	# Relations with other models
	belongs_to :book
	has_many :riders, :dependent => :destroy

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	# Validations
	validates :name, presence: true
	# Ages should be greater than 0 and less tha 200. Noted: 200 can be changed
	validates :minimum_age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 200 }
	validates :maximum_age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 200 }
	# length >= 0
	validates :paid_period_length, numericality: { only_integer: true, greater_than_or_equal_to: 0}
	validates :protection_length, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

	# Scopes
	scope :master, ->(){ where(insurance_type: 'master') }
	scope :main,  ->(){ where(insurance_type: 'main') }
	scope :rider,  ->(){ where(insurance_type: 'rider') }

	# is_mater retrun true if the plan type is 'master'
	def is_master?
		self.insurance_type == 'master'
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:name] = self.name
		attrs[:minimum_age] = self.minimum_age
		attrs[:maximum_age] = self.maximum_age
		attrs[:consider_year] = self.consider_year
		attrs[:consider_gender] = self.consider_gender
		attrs[:paid_period_length] = self.paid_period_length
		attrs[:protection_length] = self.protection_length
		attrs[:group] = self.group
		attrs[:company] = self.company
		attrs[:tag_list] = self.tag_list

		# Ref ID
		attrs[:reference_id] = self.id

		attrs
	end
end
