require 'spec_helper'
require './app/controllers/application_controller.rb'
require './app/models/note.rb'
require 'rack/test'

RSpec.describe Note do 

   before do 
        Note.create( comment: "This is only a test.")
        Note.create( comment: "This is the second test")
        Note.create( comment: "Testing is the ultimate.")
        Note.create( comment: "This is tester time!")
   end 
    
    it 'can contain a comment' do 
        expect(Note.all[0].comment).to eq("This is only a test.")
        expect(Note.all[1].comment).to eq("This is only a test.")
    end 

    it 'has four notes saved' do 
        expect(Note.all.size).to eq(4)
    end 


    context "can index content" do 

        it 'has an index which is a hash' do 
            expect(Note.index_content.class).to eql(Hash)
        end 

        it 'can return specfic content' do 
            index = Note.index_content
            expect(index['this'][0].comment).to eq(Note.all[0].comment)
        end 

        it 'returning content in an array' do 
            index = Note.index_content
            expect(index['test'].size).to eq(2)
        end 

        it "has a note3" do 
            expect(Note.all[2].comment).to eq("Testing is the ultimate.")
        end 

        it 'and search keys for partial matches using regex' do 
            index = Note.index_content
            search_word = 'test'
            result = Note.search(search_word)
            # expect(index['test'].size).to eq(2)
            # expect(result.size).to eq(2)
            expect(index.keys.size).to be > 10
            expect(index.keys.class).to eq([].class)
            expect(result.map(&:comment).size).to eq(4)
           

        end 



    end 

    after do 
        Note.delete_all
    end 

end 