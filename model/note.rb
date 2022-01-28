class Note < ActiveRecord::Base
    belongs_to :project
    belongs_to :quote 
    belongs_to :book
    has_many :addendums
    has_many :examples
    has_many :weblinks


    def last_touched 
        touch_date = self.created_at 
        if  self.addendums[-1] == nil
            return touch_date 
        else 
            last_event = self.addendums[-1]
        end 

        if last_event.notes[-1] == nil 
            return last_event.created_at 
        else
            return last_event.notes[-1].created_at
        end 

        # if date_event.addendums[-1] == nil 
        #     return date_event 
        # else 
        #     date_event = date_event.addendums[-1]
        # end 

        date_event

    end 



end 