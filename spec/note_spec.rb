require_relative "../app.rb"
require './model/note.rb'
require 'rack/test'

RSpec.describe Account do 

    let(:note) { Note.new( comment: "This is only a test.") }
    
    it 'can contain a comment' do 
        expect(note.comment).to eq("This is only a test.")
    end 

    it 'has an index which is a hash' do 
        expect(Note.note_index.class).to eql(Hash)
    end 

    it 'the has has content' do 
        expect(Note.note_index[:man]).to eq("boy")
    end 

end 