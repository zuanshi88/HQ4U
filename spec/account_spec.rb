ENV['APP_ENV'] = 'test'

require './app/controllers/application_controller.rb'
require './app/models/account.rb'
require './app/models/activity.rb'
require 'rack/test'

RSpec.describe Account do 
     include Rack::Test::Methods

        subject { Account.create({:name => "Aaron Whitmer", :street_address => "1888 W. North Ave.",
                :city => "Chicago", :state => "IL", :zipcode => 60613})}

        let(:new_activity){ Activity.create({:title => "Beach Day", :description => "Surf and Sun"})}
        let(:new_project){ Project.create({:title => "Coin Collecting", :description => "Coins from around the world"})}


        it "can create a new instance" do 
            expect(subject.class).to eq(Account)
            expect(subject.name).to eq("Aaron Whitmer")
            expect(subject.street_address).to eq("1888 W. North Ave.")
            expect(subject.city).to eq("Chicago")
            expect(subject.state).to eq("IL")
            expect(subject.zipcode).to eq(60613)
        end 
       


        it "has activities" do 
            expect(subject.activities.size).to eq(0)
        end 

        it "can add activity" do 
            subject.activities << new_activity 
            subject.save
            expect(subject.activities.size).to eq(1)
        end 

        it "has projects" do 
            expect(subject.projects.size).to eq(0)
        end 

        it "can add projects" do 
            subject.projects << new_project 
            subject.save
            expect(subject.projects.size).to eq(1)
        end 

        it "can collect people" do 
            expect(Account.all.length).to eq(5)
        end 

        Account.delete_all

end 