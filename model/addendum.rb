class Addendum < ActiveRecord::Base
    belongs_to :note
    has_many :examples
    has_many :weblinks
    has_many :notes 


        def last_touched 
        
            if self.notes[-1] == nil 
                return self.created_at
            else  
                return self.notes.sort_by{|note| note.created_at}[-1].created_at
            end 

        end 

        def addendums_with_notes
             self.notes.select{|note| !note.addendums.empty?}
        end 

end 