class Session 

    attr_reader :user, :selection , :hub, :type

    def initialize(user, selection = {type: "single"})
        @user = user 
        @selection = selection 
        @type = @selection[:type]
    end 

            class Hub 

                attr_reader :type
                
                    def initialize(type)
                        @type = type
                    end 
            end     

            def create_hub 
                @hub = Hub.new(@type)
            end 

            def hub 
                @hub
            end  


end 


RSpec.describe Session do 

    let(:session){Session.new("John")}


    it "can initialize a Session with attributes" do 
        expect(session.user).to eq("John")
        expect(session.selection).to eq({type: "single"})
    end 

    it "can intialize a Hub with a type" do 
        session.create_hub
        expect(session.hub.class).to eq(Session::Hub)
    end 

    it "can assing Hub a type" do 
         session.create_hub
         hub = session.hub 
        expect(hub.type).to eq(session.type)
    end 


end 
