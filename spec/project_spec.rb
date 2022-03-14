require_relative "../app.rb"
require './model/project.rb'
require 'rack/test'

RSpec.describe Account do 
     include Rack::Test::Methods
        subject { Project.new({:title => "Go time", :description => "Log book 3000"})}

        def index 
           subject.index_content
        end 
       
        it "has a Project class" do 
            expect(subject.class).to eq(Project)
        end 

        it "has a title" do 
            expect(subject.title).to eq("Go time")
        end 

        it "has a description" do 
            expect(subject.description).to eq("Log book 3000")
        end 

        it "has Directory module class methods" do 
            expect(subject.boo).to eq("BOO!!!")
        end 


        it "can return an index" do 
            expect(index['the'].class).to eq(Array)
        end 


end 