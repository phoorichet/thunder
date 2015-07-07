class PaCoverage < ActiveRecord::Base
	belongs_to :pa

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	scope :master, ->(){where(coverage_type: 'master')}

	validates :key, presence: true

	default_scope { order(id: :asc)}

	def is_master?
		self.coverage_type == 'master'
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:key] = self.key
		attrs[:value] = self.value
		attrs[:description] = self.description
		attrs[:reference_id] = self.id
		attrs[:tag_list] = self.tag_list

		attrs
	end
end
