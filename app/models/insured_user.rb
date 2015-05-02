class InsuredUser < ActiveRecord::Base
    # Tree enabled
    has_ancestry 

    has_many :addresses
    has_many :contracts

end
