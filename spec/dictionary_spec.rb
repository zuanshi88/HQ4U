require_relative "../app.rb"
require './model/account.rb'
require './model/entry.rb'
require 'rack/test'


RSpec.describe "Dictionary Model" do 
    let(:dictionary) { Dictionary.new }
    let(:entry) { Entry.new(term: "A Term", topic_tag: "computers")}
    let(:other_entry) { Entry.new(term: "Another Term", topic_tag: "the arts")}
    let(:real_dictionary) {Dictionary.all[1]}

    it 'has the correct class' do 
        expect(dictionary.class).to eq(Dictionary)
    end 

    it 'returns an empty array of entries' do 
        expect(dictionary.entries).to eq([])
    end 
    
    it 'can add entries' do 
        dictionary.entries << entry << other_entry 
        expect(dictionary.entries.size).to eq(2)
    end 
    
    it "has entries with attributes" do 
        expect(entry.term).to eq("A Term")
        expect(entry.topic_tag).to eq("computers")
    end 

    it 'responds to Levenshtein disance method' do 
        expect(dictionary.distance('bob', 'boob')).to eq(1)
    end 

    it 'can return closest search result' do 
        dictionary.entries << entry << other_entry 
        expect(dictionary.determine_close_matches("B Term").size).to eq(1)
    end 

    
    it 'can return closest search result' do 
        dictionary.entries << entry << other_entry 
        expect(dictionary.determine_close_matches("Another XX Term").size).to eq(1)
    end 
    context "works with a real dictionary" do 
        it 'works on a real dictionary' do 
            expect(real_dictionary.title).to eq("Ruby")
        end 

        it 'had a lot of entries' do 
            expect(real_dictionary.entries.length).to be > 100
        end

        it 'can return the correct entry' do 
            expect(real_dictionary.determine_close_matches("vadilate").size).to eq(10)
        end 

    end 
end 