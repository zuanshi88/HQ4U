class Addendum < ActiveRecord::Base
    belongs_to :note
    has_many :examples
    has_many :weblinks
    has_many :notes 


        def last_touched 
        
            if self.notes[-1] == nil 
                return self.created_at
            else  
                return self.notes[-1].created_at
            end 
            
        end 

end 