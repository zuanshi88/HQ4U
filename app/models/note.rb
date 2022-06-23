
    require './app/models/model_helper.rb'
    
    class Note < ActiveRecord::Base
        belongs_to :project, dependent: :destroy
        belongs_to :quote, dependent: :destroy
        belongs_to :book, dependent: :destroy
        belongs_to :addendum, dependent: :destroy
        has_many :addendums
        has_many :examples
        has_many :weblinks
        
       extend ModelHelper



    def has_addendums 
        self.addendums.size >= 1 ? true : false
    end



     def self.index_content
            # information = ["name", "last_name", "first_name"]
            content_hash = {}
            self.all.each do |note|
                unless note.comment == nil || note.comment == ""
                    unless note.comment.size > 15
                            content_hash[note.comment.downcase] = [] if content_hash[note.comment.downcase].nil? 
                            content_hash[note.comment.downcase].push(note)
                    end 
                    

                    note.comment.split(/[\s,'-\.!]/).each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(note)
                    end 
                end 
            end 
        content_hash
    end


    
    def open_file
      file_name = self.comment.gsub(" ", "")[0..6].downcase
      system("touch ./doc_files/#{file_name}.docx")
      system("start ./doc_files/#{file_name}.docx")
    end 

end 