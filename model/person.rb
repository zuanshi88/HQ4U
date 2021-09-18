class Person

    @@people = []

    attr_accessor :name, :street_address, :city, :state, :zip_code, :touch_points, :topics, :photo
    
    def initialize(name, street_address, city, state, zip_code, photo=nil)
        @name = name 
        @street_address = street_address
        @city = city 
        @state = state 
        @zip_code = zip_code
        @photo = photo
        @@people << self 
        @touch_points = []
        @topics = []
        @birthday = nil 
    end 

    def self.people 
        @@people
    end

    def add_touch_point(time_date, notes)
        @touch_points << TouchPoint.new(time_date, notes)
    end 

    def add_topic(topic)
        @topics << Topic.new(topic, note = "", time_date = Time.now,)
    end 

    

    class TouchPoint 

        attr_reader :date_time, :notes 

        def initialize(date_time,notes)
            @date_time = date_time
            @notes = notes
        end 
    end 

    class Topic 

        attr_reader :date_time, :topic, :note

        def initialize(topic, note, date_time)
            @date_time = date_time 
            @topic = topic 
            @note = Note.new("")
        end 

        class Note 
            def initialize(date_time = Time.now, content)
                @date_time = date_time 
                @content = content
            end 
        end 

    end 



end 