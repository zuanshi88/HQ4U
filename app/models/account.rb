class Account < ActiveRecord::Base
    has_many :activities
    has_many :projects

    # could have many notes and addendum trhough things.
    #also has many books-- lets experiment with that...


    def collected_photos 
         collected_photos = []
                
        unless self.projects.empty?
            self.projects.each do |project|
                    project.photos.each do |photo|
                        collected_photos << photo
                    end
            end
        end 

        collected_photos.shuffle!
    end 
    
    def self.name_index 
            content_hash = {}
            self.all.each do |acc|
                unless acc.name == nil || acc.name == ""
                    acc.name.split(/[\s]/).each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(acc)
                    end 
                end 
            end 
        content_hash
    end 


end 