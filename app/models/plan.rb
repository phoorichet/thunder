class Plan < ActiveRecord::Base
	belongs_to :book
	has_many :riders, :dependent => :destroy

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	scope :master, ->(){ where(plan_type: 'master') }

	def is_master?
		self.plan_type == 'master'
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:name] = self.name
		attrs[:reference_id] = self.id
		attrs[:tag_list] = self.tag_list

		attrs
	end

	# Deep copy clones all the pland details, riders, coverages associated with it.
	def deep_copy

	end

end
