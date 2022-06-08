require './app/controllers/application_controller.rb'
require './app/models/account.rb'
require 'rack/test'

RSpec.describe Account do 
     include Rack::Test::Methods
        subject { Account.new({:name => "Aaron Whitmer"})}


        it "can create a new instance" do 
            expect(subject.class).to eq(Account)
            expect(subject.name).to eq("Aaron Whitmer")
            # expect(subject.street_address).to eq("1943 W. Cuyler Ave")
            # expect(subject.city).to eq("Chicago")
            # expect(subject.state).to eq("IL")
            # expect(subject.zip_code).to eq(60613)
        end 

       let(:name){Account.new("John Doe", '111 Howe', "Gladstone", "MI", 49837)}
       
        it "has activities" do 
            expect(subject.activities.size).to eq(0)
        end 

        it "has projects" do 
            expect(subject.projects.size).to eq(0)
        end 

        it "can collect people" do 
            expect(Account.all.length).to eq(20)
        end 


end 