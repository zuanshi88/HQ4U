require 'spec_helper'
require './app/controllers/application_controller.rb'
require './app/models/entry.rb'
require 'rack/test'






#   create_table "entries", force: :cascade do |t|
#     t.integer "dictionary_id"
#     t.string "term"
#     t.string "entry_info"
#     t.string "more_info"
#     t.string "photo"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.string "topic_tag"
#     t.integer "views", default: 0
#     t.integer "difficulty", default: 10
#     t.index ["dictionary_id"], name: "index_entries_on_dictionary_id"
#   end



RSpec.describe Entry do 

   before do 
        @entry = Entry.create( dictionary_id: 16, term: "Banana", entry_info: "A yellow fruit", more_info: "sweet and filling", topic_tag: "fruit")
   end 
    

    context 'has auto generated attributes' do 

        it 'has default difficulty' do 
            expect(@entry.difficulty).to eql(10)
        end 

        it 'has default views' do 
            expect(@entry.views).to eql(0)
        end 

    end 

    context 'has assigned attributes' do 

        it 'has a term' do 
            expect(@entry.term).to eql("Banana")
        end 

        it 'has entry_info' do 
            expect(@entry.entry_info).to eql("A yellow fruit")
        end 
        
    end 

    after do 
        Entry.delete_all
    end 

end 