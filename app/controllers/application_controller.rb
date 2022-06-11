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

require "./application_helper"



class ApplicationController < Sinatra::Base
    configure :development, :test do
        register Sinatra::Reloader
            # set :database, {adapter: "sqlite3", database: "db/crm.sqlite3"}
            set :database_file, 'config/database.yml'
            set :views, "app/views"
            set :public_folder, "public"
        end

        include ApplicationHelper
        
        before do 
            @color_array = ["#624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #9f600c", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #136888", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", "#e37d26", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #c5ac66", "#c5ac66", " #3ea511", " #3ea511", " #C5AC66", " #C5AC66", " #3ea511", " #3ea511", " #64ae22", " #c4b645", " #c4b645", " #9f600c", " #b60762", " #0121e5", " #0121e5", " #6e352c", " #5c4d98", " #5c4d98", " #136888", " #136888", " #6c7dea", " #aebd16", " #aebd16", " #c941c9", " #872b3b", " #c941c9"]
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