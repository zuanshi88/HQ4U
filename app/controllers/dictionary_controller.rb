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

get '/decks/alt' do 
     @dictionaries = Dictionary.all.sort_by{|dict| dict.title}
    erb :"dictionaries/decks"
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
    
    unless @dictionary.entries[0] == nil 
        @tags = @dictionary.entries.map{|entry| entry.topic_tag}.uniq.sort
    end 


    erb :"dictionaries/dictionary"
end 

get '/dictionary/:id/:entry_id' do 
    @dictionary = Dictionary.find(params[:id])
    @entry = Entry.find(params[:entry_id])
    @entry.viewed 
    @entry.save 
    @results = [@entry] 
    erb :"dictionaries/dictionary"
end 



# are the following two routes different???? Serve different

get '/dictionary/tag/:id/:tag' do 
    @dictionary = Dictionary.find(params[:id])
    @results = @dictionary.entries.select{|entry| entry.topic_tag == params[:tag]}

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
    @dictionary.touch

    @results = [@entry]
   
    erb :"dictionaries/dictionary" 

end 


delete '/dictionary/:id/delete/:entry_id' do 
    @dictionary = Dictionary.find(params[:id])
    @entry = Entry.find(params[:entry_id])

    @entry.destroy 

    erb :"dictionaries/dictionary" 
end

get '/dictionary/entry/edit/:id/:entry_id' do
      @dictionary = Dictionary.find(params[:id])
      @entry = Entry.find(params[:entry_id])

      erb :"/dictionaries/edit_entry"
end 

patch '/dictionary/entry/update/:id/:entry_id' do 
     @dictionary = Dictionary.find(params[:id])
     @entry = Entry.find(params[:entry_id])
     @entry.term = params[:term]
     @entry.entry_info = params[:entry_info]
     @entry.more_info = params[:more_info]
     @entry.topic_tag = params[:topic_tag]
     @entry.photo = params[:photo]
     @entry.save 
     @dictionary.touch

     @results = [@entry] 

      erb :"dictionaries/dictionary"

end 



get '/dictionary/entry/update/difficulty/:id/:entry_id' do
     @dictionary = Dictionary.find(params[:id])
     @entry = Entry.find(params[:entry_id])
     @entry.decrease 
     @entry.save 
     @dictionary.touch

     @results = [@entry] 

      erb :"dictionaries/dictionary"
end 

get '/dictionary/entry/update/views/:id/:entry_id' do
     @dictionary = Dictionary.find(params[:id])
     @entry = Entry.find(params[:entry_id])
     @entry.viewed += 1
     @entry.save 
     @dictionary.touch

     @results = [@entry] 

      erb :"dictionaries/dictionary"
end 


# this controller searchs from a specific dictionary/deck search bar

get '/search/dictionary/:id' do
    @dictionary = Dictionary.find(params[:id])
    @search_word = params[:search].downcase
    @results = Entry.search(@search_word, 1)
    if !@results 
        @message = "Sorry no results for '#{params[:search]}'"
    else  
        @results.uniq!
    end 

    erb :"dictionaries/dictionary"
        
end 

#global search

get '/search/dictionaries' do 
    entry_hash = Entry.index_content
    @search_word = params[:search].downcase
    @results = Entry.search(@search_word, 2)

       

    if !@results
        @message = "Sorry no results for #{params[:search]}"
        @results = nil
    else 
        @results.uniq!
    end 

    erb :"dictionaries/decks"

end 

get '/search/dictionary/term/:id/:term' do 
     @dictionary = Dictionary.find(params[:id])
     @term_hash = Dictionary.term_index
     @term = params[:term]
     @results = [@term_hash[:term]]

     erb :"dictionaries/dictionary"

end 

get '/search/tag/dictionary/:id/:tag' do 
    @dictionary = Dictionary.find(params[:id])
    @tag = params[:tag]
    @results = Entry.all.select{|entry| entry.topic_tag == @tag}
     if @results.empty? 
        @message = "Sorry no results for #{params[:search]}"
    end 
       erb :"dictionaries/dictionary"
end 





#this controller links to an individual display of the entry from global search bar

get '/dictionary/redirect/:id/:result' do
    @dictionary = Dictionary.find(params[:id])

    # assigning @result to an array to make it pass when passed to the dictionary view
    @entry = Entry.find(params[:result])
    @entry.viewed 
    @entry.save 

    @results = [@entry]
 
    erb :"dictionaries/dictionary"
        
end 


post '/example/:entry_id' do 
    @example = Example.create(info: params[:info])
    @entry = Entry.find(params[:entry_id])
    @dictionary = Dictionary.find(@entry.dictionary_id)

    @entry.examples << @example 

    @results = [@entry]
 
    erb :"dictionaries/dictionary"
end 

delete '/example/:entry_id/:example_id' do 
    @example = Example.find(params[:example_id])
    @example.destroy 
    @entry = Entry.find(params[:entry_id])
    @dictionary = Dictionary.find(@entry.dictionary_id)

    @results = [@entry]

    erb :"dictionaries/dictionary"

end 

patch '/example/update/:id/:example_id' do 
     @example = Example.find(params[:example_id])
     @dictionary = Dictionary.find(params[:id])
     @example.info = params[:info] 
     @example.save 

     @entry = Entry.find(@example.entry_id)

     @results = [@entry]

      erb :"dictionaries/dictionary"

end 






end