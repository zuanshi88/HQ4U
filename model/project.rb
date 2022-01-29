class Project < ActiveRecord::Base
    belongs_to :account
    has_many :notes
    has_many :weblinks
    has_many :photos
    has_many :books
    has_many :addendums, through: :notes 

    #this is coupled here via the call of the las_touched method.
    
    def last_touched 
        self.notes.sort_by{|note| note.last_touched}[-1].last_touched
    end 

end 