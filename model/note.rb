class Note < ActiveRecord::Base
    belongs_to :project
    belongs_to :quote 
    belongs_to :book
    has_many :addendums
    has_many :examples
    has_many :weblinks


        # coupling alert. calling last_touched of addendum from within note!!!
    #this is quick and dirty, but I need to think around it.
    #do it easier...

    def last_element_of_sorted_addendums
        self.addendums.sort_by{ |add| add.last_touched}[-1]
    end 

    def last_addendum
        self.last_element_of_sorted_addendums
    end 

    def has_addendums 
        self.addendums.size >= 1 ? true : false
    end

    def last_touched 
        touch_date = self.created_at 
        if  !self.has_addendums
            return touch_date 
        else 
            #this is where we begin to call to addendum and therefore
            #to note via the descending last_touched calls.  
            #this coupling doesn't seem like a huge issue,
            #but should look into getting around it via a has_many through 
            #relationship
            last_event = self.last_addendum
        end     

        #how are we getting a nil class here?
        if last_event == nil || last_event.notes.empty?
            return last_event.created_at 
        else
            return last_event.notes.sort_by{|note| note.last_touched}[-1].last_touched
        end 
    end 

end 