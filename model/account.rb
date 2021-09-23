class Account < ActiveRecord::Base
    has_many :activities
end 