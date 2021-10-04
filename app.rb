require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

require_relative "model/person.rb"
require_relative "model/account.rb"
require_relative "model/agendaday.rb"
require_relative "model/activity.rb"
require_relative "model/project.rb"
require_relative "model/note.rb"
require_relative "model/topic.rb"
require_relative "model/flashcard.rb"
require_relative "model/session.rb"
require_relative "model/weblink.rb"
require_relative "model/photo.rb"
require_relative "model/dictionary.rb"
require_relative "model/entry.rb"
require_relative "model/example.rb"

set :database, {adapter: "sqlite3", database: "crm.sqlite3"}

# class App < Sinatra::Base
#     configure :development do
#         register Sinatra::Reloader
#   end

get "/flashcards" do 

    @topics = Topic.all

    erb :flashcards 
end 

get "/flashcard/:id" do
    @topic = Topic.find_by_id(params[:id].topic_id)

    @flashcards = @topic.flashcards

    erb :flashcard
end 

delete "/flashcard/delete/:id" do
    @flashcard = Flashcard.all.find(params[:id])
    @topic = Topic.all.find(@flashcard.topic_id)
    @flashcard.destroy

    erb :topic_edit

end

get "/topic/:id" do 

    @topic = Topic.find_by_id(params[:id].to_i)

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

	erb :home, :locals => {:local_a => @insult, :local_b => "you, motherfucker!!!"}
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
    @person.activities << Activity.create(title: params[:title], description: params[:description])
    @person.save

    erb :person

end 

delete "/people/:account_id/delete/:activity_id" do 
    @activity = Activity.find_by_id(params[:activity_id].to_i)
    @activity.destroy 

    @person = Account.find_by_id(params[:account_id].to_i)
    
    erb :person
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

post "/people/:id/project/:project_id/weblink/create" do 

    @weblink = Weblink.create(title: params[:title], url: params[:url], description: params[:description] )
    @project = Project.find_by_id(params[:project_id].to_i)
    @project.weblinks << @weblink
    @weblink.save 
    @project.save 

    @person = Account.find_by_id(params[:id])

    erb :project


end 

delete "/people/:project_id/weblinks/delete/:link_id" do 
    @weblink = Weblink.find_by_id(params[:link_id])
    @project = Project.find_by_id(params[:project_id])
    @person = Account.find_by_id(@project.account_id)
    @weblink.destroy

    erb :project  


end 




get '/activities' do 

    @activities = Activity.all.reverse
    @projects = Project.all.reverse
    @notes = Note.all 

    erb :activities

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


get '/dictionaries' do 
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
    @entry = Entry.create(term: params[:term], info: params[:info], more_info: params[:more_info], photo: params[:photo], topic_tag: params[:topic_tag])
    @dictionary = Dictionary.find(params[:id])
    @dictionary.entries << @entry 
    @dictionary.save  

    erb :dictionary 

end 


delete '/dictionary/:id/delete/:entry_id' do 
    @dictionary = Dictionary.find(params[:id])
    @entry = Entry.find(params[:entry_id])

    @entry.destroy 

    erb :dictionary 
end 




get '/dictionary/:id/search' do
    @search = params[:search] 
    @dictionary = Dictionary.find(params[:id])
    @result = @dictionary.entries.select{|entry| entry.term == @search}
  
    erb :dictionary
        
end 


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