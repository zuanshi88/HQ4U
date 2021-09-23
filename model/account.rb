class Account < ActiveRecord::Base
    has_many :activities
    has_many :projects
end 