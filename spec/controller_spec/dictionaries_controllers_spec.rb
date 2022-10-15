require 'spec_helper'

# require './app/controllers/application_controller.rb'
require './app/controllers/dictionary_controller.rb'
require './app/models/dictionary.rb'
require './app/models/entry.rb'
# require './app/models/activity.rb'


    RSpec.describe DictionaryController, type: :controller do 
        include Rack::Test::Methods


            before do 
                    @dictionary = Dictionary.create!(title: "Fruits" )
                    @entry = Entry.create!( dictionary_id: @dictionary.id, term: "Banana", entry_info: "A yellow fruit", more_info: "sweet and filling", topic_tag: "fruit")
            end 

             def app 
                DictionaryController
             end 


            it 'has a decks index' do 
                get '/decks'
                expect(last_response).to be_ok   
            end 


            it 'can increase views' do

                #not sure how to pass the params when testing 
                #this passes, but it does not do so against a DB

                patch '/dictionary/entry/update/views/:id/:entry_id/', params={id: @dictionary.id, entry_id: @entry.id}
                @entry.viewed 
                expect(@entry.views).to eq(1)  
            end
    end 