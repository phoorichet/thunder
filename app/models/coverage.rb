class Coverage < ActiveRecord::Base
	belongs_to :rider

	acts_as_taggable # Alias for acts_as_taggable_on :tags
end
