class Note < ActiveRecord::Base
    belongs_to :project
    belongs_to :quote 
    belongs_to :book
    has_many :addendums
    has_many :examples
    has_many :weblinks
    has_and_belongs_to_many :notes
end 