    
    
class Session < ActiveRecord::Base
  
  
  attr_accessor :cards
  
    def level
    if self.difficulty == 'greater'
        6
    elsif self.difficulty == 'less'
        5
    else  
        0 
    end  
  end 

  def seen 
    if self.views == 'greater'
        6
    elsif self.views == 'less'
        5
    else 
        0
    end 
end 

end 