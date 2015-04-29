class InsuredUser < ActiveRecord::Base
    has_many :addresses
end
