class Project < ActiveRecord::Base
    belongs_to :account
    has_many :notes
    has_many :weblinks
    has_many :photos
end 