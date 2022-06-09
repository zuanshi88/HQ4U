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

         def self.index_content
            # information = ["name", "last_name", "first_name"]
            content_hash = {}
            self.all.each do |add|
                unless add.addition == nil 
                    add.addition.split(' ').each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(add)
                    end 
                end 

                    # note.description.split(' ').each do |word|
                    #        unless word == nil 
                    #             content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                    #             content_hash[word.downcase].push(note)
                    #         end 
                    # end 
            end 
        content_hash
    end


end 