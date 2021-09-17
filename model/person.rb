class Person

    @@people = []

    attr_accessor :name, :street_address, :city, :state, :zip_code, :touch_points, :topics
    
    def initialize(name, street_address, city, state, zip_code)
        @name = name 
        @street_address = street_address
        @city = city 
        @state = state 
        @zip_code = zip_code
        @@people << self 
        @touch_points = []
        @topics = []
        @birthday = nil 
    end 

    def self.people 
        @@people
    end

    def add_touchpoint(time_date, notes)
        @touch_points << TouchPoint.new(time_date, notes)
    end 

    def add_topic(topic)
        @topics << Topic.new(topic, note = "", time_date = Time.now,)
    end 

    

    class TouchPoint 

        attr_reader :time_date, :notes 

        def initialize(time_date,notes)
            @time_date = time_date
            @notes = notes
        end 
    end 

    class Topic 
        def initialize(topic, note, time_date)
            @time_date = time_date 
            @topic = topic 
            @note = Note.new("")
        end 

        class Note 
            def initialize(time_date = Time.now, content)
                @time_date = time_date 
                @content = content
            end 
        end 

    end 



end 