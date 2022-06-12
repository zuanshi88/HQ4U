class Quote < ActiveRecord::Base
    belongs_to :book 
    belongs_to :entry
    has_many :notes, dependent: :destroy
end 