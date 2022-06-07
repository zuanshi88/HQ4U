class Weblink < ActiveRecord::Base 
    belongs_to :project
    belongs_to :book
    belongs_to :note 
    belongs_to :addendum 
end 