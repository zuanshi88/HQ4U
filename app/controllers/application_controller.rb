require "sinatra/base"
require "sinatra/reloader"
require "sinatra/activerecord"

require "openlibrary"


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
require_relative "../models/session.rb"

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
        
        #  enable :sessions 

            

        before do 
            @color_array =  ["#624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #9f600c", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", "#e37d26", " #587900", " #44d76b", " #3095b2", " #b58e54", " #c5ac66", "#c5ac66", " #3ea511", " #C5AC66", " #64ae22", " #c4b645", " #b60762", " #0121e5", " #6e352c", " #5c4d98", " #6c7dea", " #aebd16", " #c941c9", " #872b3b"]
            
            # exploring different ways to approach this
            @user = Account.find_by_id(40)
            #hard coded this response for testing purposes.
            # need to clean up the default user implmentation...
            @default_id = @default_account ? @default_account.id : 40
            # find where this has been left in -- could search
            # @person = Account.find(40)
            session[:user] = @default_account || nil 
            session[:secret_message] = "Zhe shi mimi, ni zhidao, ma?"
            session[:quote] = "Try, try again, fail again, fail better."
        end 
        
    
        
        get "/" do
            erb :home
        end

        get "/library" do 
            erb :"library"
        end 

        post "/library/book_lookup" do 
           client = Openlibrary::Client.new

           @book = client.book(params[:isbn]) 

            erb :library
        end 

# below are some somewhat random notes from sinatra docs

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
            @notes = Note.all.select{|n| n.addendum_id.nil?  }.sort_by{|note| note.updated_at}.reverse 
        
            
            # originally had this Project call in the view, 
            # but that didn't feel right at all, so I created 
            # a model method on Project
            # and passed the view a hash, instead of making 
            # a database query right from the view
            # @titles = Project.title_hash
        

            erb :"app/project_log"
        end 

        get "/activity_log" do 
            @activities = Activity.all 

            erb :"app/activity_log"
        end 

        
    get '/search' do 
    
        @search_word = params[:search_word].downcase

        @note_results = Note.search(@search_word)     
        @addendum_results = Addendum.search(@search_word)
        @entry_results = Entry.search(@search_word)
        @weblink_results = Weblink.search(@search_word)
        @project_results = Project.search(@search_word)
        @book_results = Book.search(@search_word)

        erb :"app/search_results"
    end 

    get '/redirect_search/note/:search_word/:id' do 
        @note = Note.find(params[:id])
        @search_word = params[:search_word]
        @search_word.upcase!
        @project = Project.find_by_id(@note.project_id)
        @note.touch 
        @project.touch


            # if @note.addendum_id != nil 

            # end 

            if @note.book_id != nil 
                @book = Book.find_by_id(@note.book_id)
                @book.touch
            end

            # if @note.addendum_id != nil
            #     @addendum = Addendum.find_by_id(@note.addendum_id)
            #     @upnote = Note.find_by_id(@addendum.note_id)
            #     @project = Project.find_by_id(@upnote.id)
            #     @note.project_id = @project.id 
            #     @note.save
            # end 
    

        @notes = [@note]

        erb :"app/display"
        

    end 

      get '/redirect_search/addendum/:search_word/:addendum_id' do 

        #could add an updated at method here to make addendum float to top of search
            @addendum = Addendum.find(params[:addendum_id])
            @note = Note.find(@addendum.note_id)
            @project = Project.find(@note.project_id)
            @addendum.updated_at = Time.now
            @addendum.save
            @note.touch
            @project.touch

            if @note.book_id != nil 
                @book = Book.find(@note.book_id)
            end 

            @search_word = params[:search_word]
            @search_word.upcase!

            @notes = [@note]
            @open = true

        erb :"app/display"
        

    end 



 end 