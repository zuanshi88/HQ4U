class Example < ActiveRecord::Base 
    belongs_to :entry
    belongs_to :addendum
    belongs_to :note
end 