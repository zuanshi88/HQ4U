class Project < ActiveRecord::Base
    belongs_to :account
    has_many :notes
    has_many :weblinks
    has_many :photos
    has_many :books
    has_many :addendums, through: :notes 


    # need a fuction that will simply return the last time the project was 
    # touched. 
    # created_at / note created_at / add created at...

    attr_accessor :last_touch

# project (last_touched)
# note-1 (last_touched)
# addendum (last_touched?)
# note- 2 (created_at)

# which way does comparison work?

    
    
    # def last_touched
        
    #     if self.notes.empty?
    #         return self.created_at
    #     end 

    #     base_line = self.created_at

    #     self.notes.sort_by{|note| note.last_touched }[0].created_at

    #         # if  self.notes.empty?
    #         #     return touch_date 
    #         # else 
    #         #     last_event = self.notes[-1]
    #         # end     

    #         # if last_event.addendums[-1] == nil 
    #         #      touch_date = last_event.created_at 
    #         # else
    #         #     touch_date = last_event.notes[-1].last_touched
    #         # end 

    #         # touch_date
    # end     
    
    # def last_note 
    #     if self.notes[-1] 
    #         self.notes.sort_by{|note|note.last_touched}[-1]
    #     else  
    #         self
    #     end 
    # end 

    # def last_touched
    #     l_touch = Time.now    
    #         notes_with_addendums.select do |note|
    #             note.addendums do |add|   
    #                 if l_touch < add.last_touched
    #                     l_touch = add.last_touch 
    #                 end  
    #             end 
    #         end 
    #     l_touch
    # end 

    def notes_with_addendums
       self.notes.select{|note| !note.addendums.empty?}
    end 


    def all_addendums 
        addendums_array = []
        self.notes.each{|note| addendums_array << note.addendums}
    end 

    def last_add 
        all_addendums.flatten.sort_by{|add| add.created_at}[-1].created_at
    end 

end 