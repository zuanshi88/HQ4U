require_relative 'directory_module'

class Project < ActiveRecord::Base


    include Directory

    belongs_to :account
    has_many :notes
    has_many :weblinks
    has_many :photos
    has_many :books
    has_many :addendums, through: :notes 

    #this is coupled here via the call of the last_touched method.

    def last_touched 
        self.notes.sort_by{|note| note.last_touched}[-1].last_touched
    end 

    def alternative_last_touch 
        self.addendums.sort_by{|add| add.last_touched}[-1].last_touched
    end 


    #thids will likely come out of here.

    def determine_close_matches(search, resource)
        resource.filter{ |term| self.distance(search.downcase, term.downcase) < 3 || self.distance(search.downcase, entry.topic_tag.downcase) < 3 }
    end 


    def boo 
        "BOO!!!"
    end 



end 