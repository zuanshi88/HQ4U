require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

require_relative "model/account.rb"
require_relative "model/activity.rb"
require_relative "model/project.rb"
require_relative "model/note.rb"
require_relative "model/topic.rb"
require_relative "model/flashcard.rb"
require_relative "model/weblink.rb"
require_relative "model/photo.rb"
require_relative "model/dictionary.rb"
require_relative "model/entry.rb"
require_relative "model/example.rb"
require_relative "model/book.rb"
require_relative "model/quote.rb"
require_relative "model/addendum.rb"

set :database, {adapter: "sqlite3", database: "crm.sqlite3"}

# class App < Sinatra::Base
#     configure :development do
#         register Sinatra::Reloader
#   end

before do 
    
    @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]

 end 


get "/video" do 

    erb :video
end 

get "/annuals" do
    @activities = Activity.all 

    erb :annuals
end 


get "/project_log" do 
    @notes = Note.all.select{|n| n.addendum_id.nil?  }

    
    erb :project_log
end 

get "/activity_log" do 
    @activities = Activity.all 

    erb :activity_log
end 

get "/topic/:id" do 

    @dictionary = Dictionary.find_by_id(params[:id])
    @index = 0

    erb :topic
end 

get "/topic/edit/:id" do 
    @topic = Topic.find(params[:id])

    erb :topic_edit
end 

delete "/topic/delete/:id" do 
    @topic = Topic.find_by_id(params[:id])
    @topic.destroy 

    @topics = Topic.all

    erb :flashcards

end 


post "/topic/:id/flashcard/create" do 
    @flashcard = Flashcard.create(front: params[:front], back: params[:back])
    @topic = Topic.find_by_id(params[:id]) 
    @topic.flashcards << @flashcard 
    @topic.save 

    @topics = Topic.all

    erb :flashcards

end

get "/topics" do 

    @topics = Topic.all 

erb :topics 

end 

post "/topic/create" do 
    @topic = Topic.create(title: params[:title])

    @topics = Topic.all

    erb :flashcards

end


get "/" do

	erb :home
end


get "/params/:name/:adj/:insult" do 
    erb :params 
end 

get "/people/new" do 
    
    erb :create
    
end 

post "/people/create" do 
    Account.create(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zipcode: params[:zipcode], photo: params[:photo])
  
    @people = Account.all
   
    erb :people
end 


get '/people' do 
    @people = Account.all
    erb :people 
end 


get "/people/:id" do 
    
    @person = Account.find_by_id(params[:id])
    
    erb :person
    
end 

get "/people/:id/edit_contact" do 
    @person = Account.find(params[:id])
    erb :edit_person
end 

delete "/people/:id" do 
    @person = Account.find_by_id(params[:id])
    @person.destroy 
    @people = Account.all
    erb :people
end  

patch "/people/:id/edit" do 
    @person = Account.find(params[:id])
    @person.name = params[:name]
    @person.street_address = params[:street_address]
    @person.city = params[:city]
    @person.state = params[:state]
    @person.zipcode = params[:zipcode]
    @person.save

    erb :person
end 


patch "/people/:id/photo" do 
    @person = Account.find(params[:id])
    @person.photo = params[:photo] 
    @person.save 
    
    erb :person 


end 

get "/secret" do 
    erb :secret
end 

get "/activities/:id" do 
  @person = Account.find(params[:id])

  @activities = @person.activities 

  erb :activities_personal

end 

post "/people/:id/activity/create" do
    @person = Account.find_by_id(params[:id].to_i)
    @activity = Activity.create(title: params[:title], description: params[:description], annual: params[:annual])
    @activity.created_at = params[:date]
    @person.activities << @activity
    @person.save

    erb :person

end 

delete "/people/:account_id/delete/:activity_id" do 
    @activity = Activity.find_by_id(params[:activity_id].to_i)
    @activity.destroy 

    @person = Account.find_by_id(params[:account_id].to_i)
    
    erb :person
end 



post '/project/:project_id/book/create' do

    @book = Book.create(title: params[:title], author: params[:author], synopsis: params[:synopsis], pages: params[:pages])
    @project = Project.find(params[:project_id])
    @person = Account.find(params[:project_id].account_id)
    @project.books << @book
    
    
    erb :project

end 

get '/project/:project_id/book/:book_id' do 
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])
    @person = Account.find(@project.account_id)

    erb :book

end 


post '/project/:project_id/book/:book_id/note/create' do
    @note = Note.create(comment: params[:comment])
    @book = Book.find(params[:book_id])
    @book.notes << @note 
    @project = Project.find(params[:project_id])
    @person = @project.account_id

    erb :book 

end 

delete '/project/:project_id/book/:book_id/note/:note_id/delete' do
    @note = Note.find(*params[:note_id])
    @note.destroy 
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @book = Book.find(params[:book_id])

    erb :book_edit_notes_and_quotes
end 

post '/project/:project_id/book/:book_id/note/:note_id/addendum/create' do 
    @addendum = Addendum.create(addition: params[:addition])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])

    @note.addendums << @addendum 

    erb :book 

end 



post '/project/:project_id/note/:note_id/addendum/create' do 
    @addendum = Addendum.create(addition: params[:addition])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @note.addendums << @addendum 

    erb :project

end 


delete '/project/:project_id/note/:note_id/addendum/:addendum_id/delete' do 
    @addendum = Addendum.find(params[:addendum_id])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @addendum.destroy

    erb :project
end 

post '/project/:project_id/addendum/:addendum_id/note/create' do 
    @note = Note.create(comment: params[:comment])
    @addendum = Addendum.find(params[:addendum_id])
    @addendum.notes << @note 

    @project = Project.find(params[:project_id])

    erb :project 
end 


delete '/project/:project_id/addendum/:addendum_id/note/:note_id/delete' do
    @note = Note.find(params[:note_id])
    @note.destroy 
    @project = Project.find(params[:project_id])


    erb :project
    

end 


post '/project/:project_id/book/:book_id/photo/create' do
    @photo = Photo.create(title: params[:title], photo: params[:photo], description: params[:description])
    @book = Book.find(params[:book_id])
    @book.photos << @photo 
    @project = Project.find(params[:project_id])

    erb :book

end 


delete '/project/:project_id/book/:book_id/photo/:photo_id/delete' do
    @photo = Photo.find(params[:photo_id])
    @photo.destroy 
    @book = Book.find(params[:book_id])
    @project = Project.find(params[:project_id])

    erb :photoroom_book_edit

end 

post '/project/:project_id/book/:book_id/quote/create' do
    @quote = Quote.create(text: params[:text], author: params[:author], source: params[:source])
    @book = Book.find(params[:book_id])
    @book.quotes << @quote
    @project = Project.find(params[:project_id])

    erb :book 

end 

post '/project/:project_id/book/:book_id/quote/:quote_id/delete' do
    @quote = Quote.find(params[:quote_id])
    @quote.destroy 

    erb :book 

end 


get '/project/:project_id/book/:book_id/edit_notes_and_quotes' do 
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])
    @person = Account.find(@project.account_id)

    erb :book_edit_notes_and_quotes


end 

post '/project/:project_id/book/:book_id/weblink/create' do 
    @weblink = Weblink.create(title: params[:title], url: params[:url], description: params[:description])
    @book = Book.find(params[:book_id])
    @book.weblinks << @weblink 

    erb :book 

end 

delete '/project/:project_id/book/:book_id/weblink/:weblink_id/delete' do 
    @weblink = Weblink.find(params[:weblink_id])
    @weblink.destroy 
    @book = Book.find(params[:book_id])

    erb :book 

end 





get "/people/:id/projects" do 
    @person = Account.find_by_id(params[:id].to_i)
    @projects = @person.projects

    erb :projects   
end 

post "/people/:id/project/create" do 
    @project = Project.create(title: params[:title], description: params[:description])
    @note = Note.create(comment: "another auspicious beginning!")
    @project.notes << @note 
    @person = Account.find_by_id(params[:id].to_i)
    @person.projects << @project 
    @person.save

    erb :person

end 


get "/people/:id/project/:p_id" do 
    @project = Project.find_by_id(params[:p_id])
    @person = Account.find(params[:id])

    erb :project

end 

post "/people/:id/project/:project_id/photo" do
    @photo = Photo.create(title: params[:title], photo: params[:photo], description: params[:description])
    @project = Project.find(params[:project_id])
    @project.photos << @photo 
    @project.save
    @person = Account.find(@project.account_id)

    erb :project

end


get "/photoroom/:id" do 
    @project = Project.all.find_by_id(params[:id])
    @person = Account.find(@project.account_id)

    erb :photoroom

end 

get "/photoroom/book/:id" do
    @book = Book.find(params[:id]) 
    @project = Project.find(@book.project_id)

    erb :photoroom_book 

end 

get "/photoroom/book/edit/:id" do 
    @book = Book.find(params[:id])
    @project = Project.find(@book.project_id)

    erb :photoroom_book_edit

end 


delete "/people/:account_id/project/delete/:project_id" do 
      @project = Project.find_by_id(params[:project_id].to_i)
      @project.destroy

      @person = Account.find_by_id(params[:account_id].to_i)

      erb :person 
end 

post "/people/:id/project/:project_id/note/create" do 

    @note = Note.create(comment: params[:comment])
    @project = Project.find_by_id(params[:project_id].to_i)
    @project.notes << @note 
    @note.save 
    @project.save 

    @person = Account.find_by_id(params[:id])

    erb :project


end 

delete "/people/:id/project/:project_id/delete/:note_id" do
    @note = Note.find_by_id(params[:note_id].to_i)
    @note.delete 
 
    @project = Project.find_by_id(params[:project_id])
    @person = Account.find(params[:id])
    erb :project

end 

post "/project/:project_id/*/*/weblink/create" do
    @hash = {title: params[:title], url: params[:url], description: params[:description]} 

        if params['splat'][0] =~ /main/
            @weblink = Weblink.create(@hash)
            @project = Project.find_by_id(params['splat'][1].to_i)
            @project.weblinks << @weblink
            @weblink.save 
            @project.save 

    elsif params['splat'][0] =~ /note/
        @hash[:note_id] = params[:note_id]
        @weblink = Weblink.create(@hash)
        @note = Note.find_by_id(params['splat'][1])
        @note.weblinks << @weblink

    elsif params['splat'][0] =~ /addendum/
        @weblink = Weblink.create(@hash)
        @addendum = Addendum.find_by_id(params['splat'][1])
        @addendum.weblinks << @weblink

    else 
          erb :project
    end 

    @project = @project || Project.find_by_id(params[:project_id])
    @person = Account.find_by_id(@project.account_id)

    erb :project


end 

delete "/people/:project_id/weblinks/delete/:link_id" do 
    @weblink = Weblink.find_by_id(params[:link_id])
    @project = Project.find_by_id(params[:project_id])
    @person = Account.find_by_id(@project.account_id)
    @weblink.destroy

    erb :project  


end 


 


get '/action' do 
    @account = Account.find(40)
    @activities = Activity.all
    @projects = @account.projects
    @notes = Note.all.filter{|note| note.project_id } 
    
    @projects = @projects.sort_by{ |project| project.updated_at }


    erb :action

end




get "/about" do
	erb :about
end

get '/meetings' do 
    erb :meetings
end 



get '/flashtree' do 


    erb :flashtree
end 

get '/flashbox' do

    erb :flashbox
end


get '/decks' do 
     @dictionaries = Dictionary.all
    erb :dictionaries
end 

post '/dictionary/create' do
    @dictionary = Dictionary.create(title: params[:title])
    @dictionaries = Dictionary.all 
    erb :dictionaries
end 

delete '/dictionary/:id/delete' do 
    @dictionary = Dictionary.find(params[:id])

    @dictionary.destroy

    @dictionaries = Dictionary.all

    erb :dictionaries

end 

get '/dictionary/edit/:id' do 
    @dictionary = Dictionary.find(params[:id])

    erb :edit_dictionary
end 

get '/dictionary/:id' do 
    @dictionary = Dictionary.find(params[:id])
    erb :dictionary
end 

get '/dictionary/:id/tag/:tag' do 
    @dictionary = Dictionary.find(params[:id])
    @topic_entries = @dictionary.entries.select{|entry| entry.topic_tag == params[:tag]}

    erb :dictionary_collection
end 

post '/dictionary/:id/entry/create' do
    @entry = Entry.create(term: params[:term], entry_info: params[:entry_info], more_info: params[:more_info], topic_tag: params[:topic_tag], photo: params[:photo])
    @dictionary = Dictionary.find(params[:id])
    @dictionary.entries << @entry 
   
    erb :dictionary 

end 


delete '/dictionary/:id/delete/:entry_id' do 
    @dictionary = Dictionary.find(params[:id])
    @entry = Entry.find(params[:entry_id])

    @entry.destroy 

    erb :dictionary 
end 


# this controller searchs from main dictionary serach bar

get '/dictionary/search/:id' do
    @dictionary = Dictionary.find(params[:id])
    @result = @dictionary.determine_close_entry_matches(params[:search])
    if @result.empty? 
        @message = "Sorry no results for #{params[:search]}"
    end 

    erb :dictionary
        
end 

#this controller links to an individual display of the entry.

get '/dictionary/:id/:search' do
    @dictionary = Dictionary.find(params[:id])

    # assigning @result to an array to make it pass when passed to the dictionary view
    @result = [Entry.find(params[:search])]
 
    erb :dictionary
        
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
 
    erb :dictionary 
end 

delete '/example/:entry_id/:example_id/delete' do 
    @example = Example.find(params[:example_id])
    @example.destroy 
    @entry = Entry.find(params[:entry_id])
    @dictionary = Dictionary.find(@entry.dictionary_id)


    erb :dictionary

end 


# end 