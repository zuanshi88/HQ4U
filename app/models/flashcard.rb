    
    
    class Flashcard < ActiveRecord::Base
      belongs_to :topic
      belongs_to :entry
  
     
end 