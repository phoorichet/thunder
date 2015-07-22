class Coverage < ActiveRecord::Base
	belongs_to :rider

	# Self relation
	has_many :sub_coverages, class_name: "Coverage", foreign_key: "coverage_id"
	belongs_to :coverage, class_name: "Coverage"

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	scope :master, ->(){ where(coverage_type: 'master') }
	scope :only_parent, ->(){ where("coverage_id is NULL") }

	validates :key, presence: true

	default_scope { order(created_at: :desc) }

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
		attrs[:rider_id] = self.rider_id
		attrs[:tag_list] = self.tag_list

		attrs
	end
end
