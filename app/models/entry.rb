 require './app/models/model_helper.rb'
    
    class Entry < ActiveRecord::Base 
        belongs_to  :dictionary
        has_many :examples, dependent: :destroy
        has_many :quotes
        
        extend ModelHelper

        attr_reader :decrease
       
    def decrease 
        self.difficulty -= 1
    end 

    def viewed 
        self.views += 1
    end 

      def self.index_content
            # information = ["name", "last_name", "first_name"]

            #   t.integer "dictionary_id"
            #   t.string "term"
            #   t.string "entry_info"
            #   t.string "more_info"
            #   t.string "topic_tag"
            #   examples  (info) entry_id
            content_hash = {}
            self.all.each do |entry|
                    unless entry.term == nil 
                        entry.term.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(entry)
                        end 
                    end 
                    unless entry.entry_info == nil || entry.entry_info == ""
                        entry.term.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(entry)
                        end 
                    end 
                    unless entry.more_info == nil || entry.more_info == ""
                        entry.more_info.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(entry)
                        end 
                    end 
                    unless entry.topic_tag == nil || entry.topic_tag == ""
                        entry.topic_tag.split(/[\s,'-]/).each do |word|
                                content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                content_hash[word.downcase].push(entry)
                        end 
                    end 
                    if entry.examples[0] 
                        entry.examples.each do |example|
                            unless example.info == nil || example.info == ""
                                example.info.split(/[\s,'-]/).each do |word|
                                    content_hash[word.downcase] = [] if content_hash[word.downcase].nil? 
                                    content_hash[word.downcase].push(entry)
                                end 
                            end 
                        end 
                    end 
                end 
            content_hash
        end



end 