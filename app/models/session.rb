    
    
class Session < ActiveRecord::Base
  def level
    if self.difficulty == 'greater'
        6
    else  
        5
    end 
  end 

  def seen 
    if self.views == 'greater'
        6
    else 
        5
    end 
end 

end 