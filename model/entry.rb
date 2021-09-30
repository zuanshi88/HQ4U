
class Entry < ActiveRecord::Base 
    belongs_to  :dictionary
    has_many :examples
end 