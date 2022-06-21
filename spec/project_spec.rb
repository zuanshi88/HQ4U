require './app/controllers/application_controller.rb'
require './app/models/project.rb'
require './app/models/note.rb'
require 'rack/test'

RSpec.describe Project do 
     include Rack::Test::Methods
        subject { Project.create({:title => "Go Time", :description => "Log book 3000"})}

       
        it "has a Project class" do 
            expect(subject.class).to eq(Project)
        end 

        it "has a title" do 
            expect(subject.title).to eq("Go Time")
        end 

        it "has a description" do 
            expect(subject.description).to eq("Log book 3000")
        end 


        it "can return an index" do 
            subject.notes << Note.new(comment: "This is only a test.")
            index = Project.index_content 
            expect(index['go'][0].title).to eq("Go Time")
        end 

        Project.delete_all


end 