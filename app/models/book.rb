class Book < ActiveRecord::Base
    belongs_to :project
    has_many :photos 
    has_many :notes 
    has_many :quotes 
    has_many :weblinks
end 