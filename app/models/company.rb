class Company < ActiveRecord::Base
	has_many :workings
	has_many :users, through: :workings
end
