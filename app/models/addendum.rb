
   require './app/models/model_helper.rb'
   
   class Addendum < ActiveRecord::Base
    belongs_to :note
    has_many :examples
    has_many :weblinks, dependent: :destroy
    has_many :notes, dependent: :destroy
    
    extend ModelHelper

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
            content_hash = {}
            self.all.each do |add|
                unless add.addition == nil 
                    add.addition.split(/[\s,-\.]/).each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(add)
                    end 
                end 
            end 
        content_hash
    end

        
    def open_file
      file_name = self.addition.gsub(/[\s'"]/, "")[0..6].downcase
      system("touch ./doc_files/#{file_name}.docx")
      system("start ./doc_files/#{file_name}.docx")
    end 


end 