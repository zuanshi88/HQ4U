class Addendum < ActiveRecord::Base
    belongs_to :note
    has_many :examples
    has_many :weblinks
    has_many :notes 
end 