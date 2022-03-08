require_relative '../model/account.rb'

RSpec.describe Person do 

        subject { Account.new("Aaron Whitmer", "1943 W. Cuyler Ave", "Chicago", "IL", 60613)}


        it "can create a new instance" do 
            expect(subject.class).to eq(Account)
            expect(subject.name).to eq("Aaron Whitmer")
            expect(subject.street_address).to eq("1943 W. Cuyler Ave")
            expect(subject.city).to eq("Chicago")
            expect(subject.state).to eq("IL")
            expect(subject.zip_code).to eq(60613)
        end 

       let(:name){Person.new("John Doe", '111 Howe', "Gladstone", "MI", 49837)}
       
       it "can add a touch point" do 
            subject.add_touchpoint(Time.now, "Went to zoo")
            subject.add_touchpoint(Time.now, "Ate at Wendy's")
            expect(subject.touch_points.length).to eq(2)
            expect(subject.touch_points[0].notes).to eq("Went to zoo")
        end 

        it "can collect people" do 
            expect(Person.people.length).to eq(2)
        end 


        it "can add a topic" do 
            subject.add_topic("running")
            expect(subject.topics.length).to eq(1)
        end 

end 