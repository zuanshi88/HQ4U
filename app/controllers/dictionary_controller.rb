class DictionaryController < ApplicationController
    


get "/topic/:id" do 

    @dictionary = Dictionary.find_by_id(params[:id])
    @index = 0

    erb :"dictionaries/topic"
end 

get "/topic/edit/:id" do 
    @topic = Topic.find(params[:id])

    erb :"dictionaries/topic_edit"
end 

delete "/topic/delete/:id" do 
    @topic = Topic.find_by_id(params[:id])
    @topic.destroy 

    @topics = Topic.all

    erb :"dictionaries/flashcards"

end 


post "/topic/:id/flashcard/create" do 
    @flashcard = Flashcard.create(front: params[:front], back: params[:back])
    @topic = Topic.find_by_id(params[:id]) 
    @topic.flashcards << @flashcard 
    @topic.save 

    @topics = Topic.all

    erb :"dictionares/flashcards"

end

get "/topics" do 

    @topics = Topic.all 

erb :"dictionaries/topics"

end 

post "/topic/create" do 
    @topic = Topic.create(title: params[:title])

    @topics = Topic.all

    erb :"dictionaries/flashcards"

end


get '/flashtree' do 


    erb :"dictionaries/flashtree"
end 

get '/flashbox' do

    erb :"dictionaries/flashbox"
end


get '/decks' do 
     @dictionaries = Dictionary.all
    erb :"dictionaries/dictionaries"
end 

post '/dictionary/create' do
    @dictionary = Dictionary.create(title: params[:title])
    @dictionaries = Dictionary.all 
    erb :"dictionaries/dictionaries"
end 

delete '/dictionary/:id/delete' do 
    @dictionary = Dictionary.find(params[:id])

    @dictionary.destroy

    @dictionaries = Dictionary.all

    erb :"dictionaries/dictionaries"

end 

get '/dictionary/edit/:id' do 
    @dictionary = Dictionary.find(params[:id])

    erb :"dictionaries/edit_dictionary"
end 

get '/dictionary/:id' do 
    @dictionary = Dictionary.find(params[:id])
    erb :"dictionaries/dictionary"
end 

get '/dictionary/:id/:entry_id' do 
    @dictionary = Dictionary.find(params[:id])
    @result = []
    @result[0] = Entry.find_by_id(params[:entry_id])
    erb :"dictionaries/dictionary"
end 



get '/dictionary/:id/tag/:tag' do 
    @dictionary = Dictionary.find(params[:id])
    @topic_entries = @dictionary.entries.select{|entry| entry.topic_tag == params[:tag]}

    erb :"dictionaries/dictionary_collection"
end 

post '/dictionary/entry/:id' do
    @entry = Entry.create(term: params[:term], entry_info: params[:entry_info], more_info: params[:more_info], topic_tag: params[:topic_tag], photo: params[:photo])
    @dictionary = Dictionary.find(params[:id])
    @dictionary.entries << @entry 
   
    erb :"dictionaries/dictionary" 

end 


delete '/dictionary/:id/delete/:entry_id' do 
    @dictionary = Dictionary.find(params[:id])
    @entry = Entry.find(params[:entry_id])

    @entry.destroy 

    erb :"dictionaries/dictionary" 
end 


# this controller searchs from dictionary/deck search bar

get '/search/dictionary/:id' do
    @dictionary = Dictionary.find(params[:id])
    @result = @dictionary.determine_close_entry_matches(params[:search])
    if @result.empty? 
        @message = "Sorry no results for #{params[:search]}"
    end 

    erb :"dictionaries/dictionary"
        
end 

#this controller links to an individual display of the entry from global search bar

get '/dictionary/redirect/:id/:result' do
    @dictionary = Dictionary.find(params[:id])

    # assigning @result to an array to make it pass when passed to the dictionary view
    @result = [Entry.find(params[:result])]
 
    erb :"dictionaries/dictionary"
        
end 


post '/example/:entry_id/create' do 
    @example = Example.create(info: params[:info])
    @entry = Entry.find(params[:entry_id])
    @dictionary = Dictionary.find(@entry.dictionary_id)

    @entry.examples << @example 
 
    erb :"dictionaries/dictionary"
end 

delete '/example/:entry_id/:example_id/delete' do 
    @example = Example.find(params[:example_id])
    @example.destroy 
    @entry = Entry.find(params[:entry_id])
    @dictionary = Dictionary.find(@entry.dictionary_id)


    erb :"dictionaries/dictionary"

end 






end