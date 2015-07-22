class Pa < ActiveRecord::Base
	has_many :pa_coverages, :dependent => :destroy
	belongs_to :book

	acts_as_taggable # Alias for acts_as_taggable_on :tags

	validates :name, presence: true

	scope :master, ->(){ where(pa_type: 'master')}

	def is_master?
		self.pa_type == 'master'
	end

	# copied_attributes copies only some attributes and return as a hash
	def copied_attributes
		attrs = {}
		attrs[:name] = self.name
		attrs[:description] = self.description
		attrs[:status] = self.status
		attrs[:premium] = self.premium
		attrs[:amount] = self.amount
		attrs[:maximum_cover_age] = self.maximum_cover_age
		attrs[:reference_id] = self.id
		attrs[:tag_list] = self.tag_list

		attrs
	end

	def pacoverages
		[]
	end

end
