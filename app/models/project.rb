
require './app/models/model_helper.rb'

class Project < ActiveRecord::Base
    
   
    extend ModelHelper

    belongs_to :account
    has_many :notes, dependent: :destroy
    has_many :weblinks
    has_many :photos
    has_many :books, dependent: :destroy
    has_many :addendums, through: :notes 
   

    #this is coupled here via the call of the last_touched method.



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

    def project_notes 
        project_notes = self.notes.filter{|note| note.addendum_id.nil? && note.book_id.nil? }
        project_notes.sort_by{|note| note.updated_at}.reverse
    end 

    def self.title_hash 
        titles = {}
        Project.all.each do |proj|
            titles[proj.id] = proj.title
        end 
        titles
    end 

end 