

class Project < ActiveRecord::Base


    belongs_to :account
    has_many :notes, dependent: :destroy
    has_many :weblinks
    has_many :photos
    has_many :books, dependent: :destroy
    has_many :addendums, through: :notes 
   

    #this is coupled here via the call of the last_touched method.

    def last_touched 
        if notes[0] != nil
            self.notes.sort_by{|note| note.last_touched}[-1].last_touched
        end 
    end 

    def alternative_last_touch 
        self.addendums.sort_by{|add| add.last_touched}[-1].last_touched
    end 


    #thids will likely come out of here.

    def determine_close_matches(search, resource)
        resource.filter{ |term| self.distance(search.downcase, term.downcase) < 3 || self.distance(search.downcase, entry.topic_tag.downcase) < 3 }
    end 

    def self.index_content 

    # t.string "title"
    # t.string "description"
        content_hash = {}
        self.all.each do |proj|
                unless proj.title == nil || proj.title == ""
                    proj.title.split(/[\s,'-]/).each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(proj)
                    end 
                            content_hash[proj.title.downcase] = [] if content_hash[proj.title.downcase].nil? 
                            content_hash[proj.title.downcase].push(proj)
                end  
                   unless proj.description == nil || proj.description == ""
                    proj.description.split(/[\s,'-]/).each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(proj)
                    end 
                end  
            end 
        content_hash
    end 

    def boo 
        "BOO!!!"
    end 



end 