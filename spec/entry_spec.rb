require 'spec_helper'
require './app/controllers/application_controller.rb'
require './app/models/entry.rb'






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

            it 'has default values' do 
                expect(@entry.difficulty).to eql(10)
                expect(@entry.views).to eql(0)
            end 

        end 

        context 'has assigned attributes' do 

            it 'has assigned values' do 
                expect(@entry.term).to eql("Banana")
                expect(@entry.entry_info).to eql("A yellow fruit")
                expect(@entry.more_info).to eql("sweet and filling")
                expect(@entry.views).to eql(0)
                expect(@entry.difficulty).to eql(10)
            end 
            
        end 

        context 'has dynamic attribtutes' do 


            it 'can decrease difficulty' do 
                @entry.decrease
                expect(@entry.difficulty).to eql(9)
            end 

            it 'can increase views' do 
                 @entry.viewed 
                 expect(@entry.views).to eql(1)
            end     

        end 


    after do 
        Entry.delete_all
    end 

end 