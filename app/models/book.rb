class Book < ActiveRecord::Base
    belongs_to :project
    has_many :photos
    has_many :notes, dependent: :destroy 
    has_many :quotes, dependent: :destroy 
    has_many :weblinks



     def self.index_content 

    # t.string "title"
    # t.string "author"
    # t.string "synopsis"
        content_hash = {}
        self.all.each do |book|
                unless book.title == nil || book.title == ""
                    book.title.split(/[\s,'-]/).each do |word|
                            content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                            content_hash[word.downcase].push(book)
                            content_hash[book.title.downcase] = [] if content_hash[book.title.downcase].nil? 
                            content_hash[book.title.downcase].push(book)
                     end 
                end  
                        unless book.title == nil || book.title == ""
                                book.author.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(book)
                            end 
                        end 
                        unless book.author == nil || book.author == ""
                                content_hash[book.author.downcase] = [] if content_hash[book.author.downcase].nil? 
                                content_hash[book.author.downcase].push(book)
                        end 
                   unless book.synopsis == nil || book.synopsis == ""
                        book.synopsis.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(book)
                        end 
                     end  
            end 
        content_hash
    end 




end 