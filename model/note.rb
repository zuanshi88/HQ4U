class Note < ActiveRecord::Base
    belongs_to :project
    belongs_to :quote 
    belongs_to :book
    has_many :addendums
    has_many :examples
    has_many :weblinks


    def date 
        date_event = self 
        if  self.addendums[-1] == nil
            return date_event 
        else 
            date_event = date_event.addendums[-1]
        end 

        if date_event.notes[-1] == nil 
              return date_event 
        else
            date_event = date_event.notes[-1]
        end 

        # if date_event.addendums[-1] == nil 
        #     return date_event 
        # else 
        #     date_event = date_event.addendums[-1]
        # end 

        date_event

    end 



end 