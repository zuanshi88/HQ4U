    
    
    class Photo < ActiveRecord::Base
        belongs_to :project
        belongs_to :book 

       

    end 