class Coverage < ActiveRecord::Base
	belongs_to :rider

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	scope :master, ->(){where(coverage_type: 'master')}

	def is_master?
		self.coverage_type == 'master'
	end
end
