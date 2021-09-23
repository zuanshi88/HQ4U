class AgendaDay

    @@days = []

  attr_accessor  :activities, :days 

  def initialize(date_time)
    @date_time = date_time
    @activities = []
    @@days << self 
  end


 
  def self.create_range(time)
    30.times do |i|
    time = time + (60 * 60 * 24)
    AgendaDay.new(time)
    end
end

def self.days 
    @@days 
end 




  def date_time
    @date_time
  end


  def add_activity(activity, notes)
      @activities << Activity.new(activity, notes)
  end

  class Activity

    attr_reader :activity, :notes

    def initialize(activity, notes)
      @activity = activity
      @notes = notes
    end
  end

end
