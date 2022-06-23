require 'did_you_mean'

module ModelHelper 
        

    def search(search_word, dist = 2)
        results = []
        created_index = self.index_content
        s_word = search_word.downcase

        hits = created_index.keys.filter{ |key| self.distance(s_word, key) < dist }

        created_index.keys.each do |key| 
            if key.include?(s_word) 
                hits << key 
            end 
        end 
        sorted_hits = hits.sort_by{|k| self.distance(s_word, k) }
        sorted_hits.each{ |h| results << created_index[h] }
        
        r_results = results.flatten.uniq
         r_results.empty? ? nil : r_results 
    end 


    def distance(word1, word2)
        DidYouMean::Levenshtein.distance(word1, word2)
    end 

    # def determine_close_matches(search, resource)
    #     resource.filter{ |term| self.distance(search.downcase, term.downcase) < 3 || self.distance(search.downcase, entry.topic_tag.downcase) < 3 }
    # end 



end 