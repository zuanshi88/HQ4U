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



class ApplicationController < Sinatra::Base
    configure :development, :test do
        register Sinatra::Reloader
        
            # set :database, {adapter: "sqlite3", database: "db/crm.sqlite3"}
            set :database_file, 'config/database.yml'
            set :views, "app/views"
            set :public_folder, "public"
        end
        
        before do 
            @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]
        end 
        
        
        get "/" do
            
            erb :home
        end

        get "/about" do
            erb :"app/about"
        end
        
        get "/video" do 
            
            erb :video
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

 end 