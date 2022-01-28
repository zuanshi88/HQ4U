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

    def initialize
        @last_touch = self.created_at 
    end 

    def last_note 
        self.notes[-1].created_at
    end 

    def last_touch
        if !self.addendums.empty?
               self.addendums.last.created_at
        elsif !self.notes.empty?
            self.notes.last.created_at
        else
            self.created_at
        end
    end 

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