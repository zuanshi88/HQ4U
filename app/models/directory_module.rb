module Directory 
        
    def index_content
            # information = ["name", "last_name", "first_name"]
            content_hash = {}
            Project.each do |project|
              unless project.notes.empty?
                project.notes.each do |note|
                    note.title.split(' ').each do |word|
                        unless word == nil 
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(note)
                        end 
                    end 
                end 

                    note.description.split(' ').each do |word|
                           unless word == nil 
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(note)
                            end 
                    end
                end 
            end 
        content_hash
    end

    def boo 
        "BOO!!!"
    end 

    def self.boom
        "Self boom!!"
    end 


    def testing 
        "This is a test!!!!"
    end 

end 