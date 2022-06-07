class DictionaryController < Sinatra::Base
    
       set :views, "app/views"
       set :public_folder, "public"

        before do 
    
             @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]

         end 


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

get '/dictionary/:id/tag/:tag' do 
    @dictionary = Dictionary.find(params[:id])
    @topic_entries = @dictionary.entries.select{|entry| entry.topic_tag == params[:tag]}

    erb :"dictionaries/dictionary_collection"
end 

post '/dictionary/:id/entry/create' do
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


# this controller searchs from main dictionary serach bar

get '/dictionary/search/:id' do
    @dictionary = Dictionary.find(params[:id])
    @result = @dictionary.determine_close_entry_matches(params[:search])
    if @result.empty? 
        @message = "Sorry no results for #{params[:search]}"
    end 

    erb :"dictionaries/dictionary"
        
end 

#this controller links to an individual display of the entry.

get '/dictionary/:id/:search' do
    @dictionary = Dictionary.find(params[:id])

    # assigning @result to an array to make it pass when passed to the dictionary view
    @result = [Entry.find(params[:search])]
 
    erb :"dictionaries/dictionary"
        
end 

# get '/dictionary/:search/:id' do
#     @dictionary = Dictionary.find(params[:id])
#     @result = @dictionary.determine_close_entry_matches(params[:search])
#     if @result.empty? 
#         @message = "Sorry no results for #{params[:search]}"
#     end 

#     erb :dictionary
        
# end 


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