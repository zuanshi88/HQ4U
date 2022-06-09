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


    def determine_close_matches(search, resource)
        resource.filter{ |term| self.distance(search.downcase, term.downcase) < 3 || self.distance(search.downcase, entry.topic_tag.downcase) < 3 }
    end 

    def self.note_index 
        @note_index||= Note.set_note_index 
    end 

    def self.set_note_index
        @note_index = { :man => "boy", :woman => "girl"}
    end 

    #write a test to test the fuller functionality here.


     def self.index_content
            # information = ["name", "last_name", "first_name"]
            content_hash = {}
            self.all.each do |note|
                unless note.comment == nil 
                    note.comment.split(' ').each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(note)
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