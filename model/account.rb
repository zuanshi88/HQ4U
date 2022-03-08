class Account < ActiveRecord::Base
    has_many :activities
    has_many :projects

    # could have many notes and addendum trhough things.
    #also has many books-- lets experiment with that...
end 