
require 'did_you_mean'


class Dictionary < ActiveRecord::Base
    has_many :entries


    
    
    def distance(word1, word2)
        DidYouMean::Levenshtein.distance(word1, word2)
    end 
    
    def create_index(array)

    end 

    #this 

    def determine_close_entry_matches(search)
        self.entries.filter{ |entry| self.distance(search.downcase, entry.term.downcase) < 3 || self.distance(search.downcase, entry.topic_tag.downcase) < 3 }
    end 

   def determine_close_entry_matches(search)
        self.entries.filter{ |entry| self.distance(search.downcase, entry.term.downcase) < 3 || self.distance(search.downcase, entry.topic_tag.downcase) < 3 }
    end 

    # def find_result(search_obj)
    #     self.entries.filter{|entry| !!(entry.term =~ /search_obj.term/i) || !!(entry.topic_tag =~ /search_obj.topic_tag/i) }
    # end 
end 