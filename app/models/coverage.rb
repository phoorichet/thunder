class Coverage < ActiveRecord::Base
	belongs_to :rider

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	scope :master, ->(){where(coverage_type: 'master')}

	validates :name, presence: true

	default_scope { order(id: :asc)}

	def is_master?
		self.coverage_type == 'master'
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:name] = self.name
		attrs[:assured_amount] = self.assured_amount
		attrs[:category] = self.category
		attrs[:premium_amount] = self.premium_amount
		attrs[:premium_unit] = self.premium_unit
		attrs[:coverage_unit] = self.coverage_unit
		attrs[:coverage_end_at] = self.coverage_end_at
		attrs[:description] = self.description
		attrs[:reference_id] = self.id
		attrs[:tag_list] = self.tag_list


		attrs
	end
end
