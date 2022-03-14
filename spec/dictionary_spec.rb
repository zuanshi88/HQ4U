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
    
    
    it "has entries with attributes" do 
        expect(entry.term).to eq("A Term")
        expect(entry.topic_tag).to eq("computers")
    end 

    it 'responds to Levenshtein disance method' do 
        expect(dictionary.distance('bob', 'boob')).to eq(1)
    end 

context "constains and accesses entries" do 

    dictionary = Dictionary.new 

    dictionary.entries <<  Entry.new(term: "A Term", topic_tag: "computers")
    dictionary.entries << Entry.new(term: "Another Term", topic_tag: "the arts")

    it 'can add entries' do 
        expect(dictionary.entries.size).to eq(2)
    end 

    it 'can return closest search result' do 
        expect(dictionary.determine_close_entry_matches("B Term").size).to eq(1)
    end 
    
    it 'can return closest search result' do 
        expect(dictionary.determine_close_entry_matches("Another XTerm").size).to eq(1)
    end 
end 

    context "works with a real dictionary" do 

        it 'works on a real dictionary' do 
            expect(real_dictionary.title).to eq("Ruby")
        end 

        it 'had a lot of entries' do 
            expect(real_dictionary.entries.length).to be > 100
        end

        it 'can return the correct entry' do 
            expect(real_dictionary.determine_close_entry_matches("vadilate").size).to eq(10)
        end 

    end 



end 