class Addendum < ActiveRecord::Base
    belongs_to :note
    has_many :examples
    has_many :weblinks
    has_many :notes 


        def date 

            date_event = self 

            if date_event.notes[-1] == nil 
                return date_event 
            else  
                return date_event
                date_event = date_event.notes[-1] 
            end 
        end 

end 