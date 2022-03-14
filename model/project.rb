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


    def index_content
            # information = ["name", "last_name", "first_name"]
            content_hash = {}
            Project.all.each do |project|
              unless project.notes.empty?
                    project.notes.each do |note|
                        note.comment do |comment| 
                            comment.split(' ').each do |word|
                                unless word == nil 
                                    content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                    content_hash[word.downcase].push(note)
                                end 
                            end 
                        end
                    end 
                end 
            end 
        content_hash
    end

    def boo 
        "BOO!!!"
    end 



end 