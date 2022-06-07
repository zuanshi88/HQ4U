require "sinatra/base"
require "sinatra/reloader"
require "sinatra/activerecord"


require_relative "../models/account.rb"
require_relative "../models/activity.rb"
require_relative "../models/project.rb"
require_relative "../models/note.rb"
require_relative "../models/topic.rb"
require_relative "../models/flashcard.rb"
require_relative "../models/weblink.rb"
require_relative "../models/photo.rb"
require_relative "../models/dictionary.rb"
require_relative "../models/entry.rb"
require_relative "../models/example.rb"
require_relative "../models/book.rb"
require_relative "../models/quote.rb"
require_relative "../models/addendum.rb"

set :database, {adapter: "sqlite3", database: "crm.sqlite3"}

class ApplicationController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    
    set :views, "app/views"
    set :public_folder, "public"
  end
  
  before do 
    
    @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]
    
  end 
  
  
  # to do --- 
  #   - weblink controller 
  #   - photo controller 
  # - people controller
  # - activity controller
  
  
  
  get "/" do
    
    erb :"app/home"
  end

  get "/about" do
	  erb :"app/about"
  end
  
  get "/video" do 
    
    erb :video
  end 
  
  get "/annuals" do
    @activities = Activity.all 
    
    erb :"app/annuals"
  end 
  
  get '/action' do 
      @account = Account.find(40)
      @activities = Activity.all
      @projects = @account.projects
      @notes = Note.all.filter{|note| note.project_id } 
      
  
      erb :"app/action"
  
  end

get "/project_log" do 
    @notes = Note.all 

    erb :"app/project_log"
end 

get "/activity_log" do 
    @activities = Activity.all 

    erb :"app/activity_log"
end 





get "/people/new" do 
    
    erb :"people/create"
    
end 

post "/people/create" do 
    Account.create(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zipcode: params[:zipcode], photo: params[:photo])
  
    @people = Account.all
   
    erb :"people/people"
end 


get '/people' do 
    @people = Account.all
    erb :"people/people"
end 


get "/people/:id" do 
    
    @person = Account.find_by_id(params[:id])
    
    erb :"people/person"
    
end 

get "/people/:id/edit_contact" do 
    @person = Account.find(params[:id])
    erb :"people/edit_person"
end 

delete "/people/:id" do 
    @person = Account.find_by_id(params[:id])
    @person.destroy 
    @people = Account.all
    erb :"people/people"
end  

patch "/people/:id/edit" do 
    @person = Account.find(params[:id])
    @person.name = params[:name]
    @person.street_address = params[:street_address]
    @person.city = params[:city]
    @person.state = params[:state]
    @person.zipcode = params[:zipcode]
    @person.save

    erb :"people/person"
end 


patch "/people/:id/photo" do 
    @person = Account.find(params[:id])
    @person.photo = params[:photo] 
    @person.save 
    
    erb :"people/person"

end 


get "/activities/:id" do 
  @person = Account.find(params[:id])

  @activities = @person.activities 

  erb :"activities/activities_personal"

end 

post "/people/:id/activity/create" do
    @person = Account.find_by_id(params[:id].to_i)
    @activity = Activity.create(title: params[:title], description: params[:description], annual: params[:annual])
    @activity.created_at = params[:date]
    @person.activities << @activity
    @person.save

    erb :"people/person"

end 

delete "/people/:account_id/delete/:activity_id" do 
    @activity = Activity.find_by_id(params[:activity_id].to_i)
    @activity.destroy 

    @person = Account.find_by_id(params[:account_id].to_i)
    
    erb :"people/person"
end 





delete '/project/:project_id/book/:book_id/photo/:photo_id/delete' do
    @photo = Photo.find(params[:photo_id])
    @photo.destroy 
    @book = Book.find(params[:book_id])
    @project = Project.find(params[:project_id])

    erb :"photos/photoroom_book_edit"

end 


post "/people/:id/project/:project_id/photo" do
    @photo = Photo.create(title: params[:title], photo: params[:photo], description: params[:description])
    @project = Project.find(params[:project_id])
    @project.photos << @photo 
    @project.save
    @person = Account.find(@project.account_id)

    erb :"projects/project"

end


get "/photoroom/:id" do 
    @project = Project.all.find_by_id(params[:id])
    @person = Account.find(@project.account_id)

    erb :"photos/photoroom"

end 

get "/photoroom/book/:id" do
    @book = Book.find(params[:id]) 
    @project = Project.find(@book.project_id)

    erb :"photos/photoroom_book" 

end 

get "/photoroom/book/edit/:id" do 
    @book = Book.find(params[:id])
    @project = Project.find(@book.project_id)

    erb :"photos/photoroom_book_edit"

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

    erb :"projects/project"


end 

delete "/people/:project_id/weblinks/delete/:link_id" do 
    @weblink = Weblink.find_by_id(params[:link_id])
    @project = Project.find_by_id(params[:project_id])
    @person = Account.find_by_id(@project.account_id)
    @weblink.destroy

    erb :"projects/project"  


end 


end 