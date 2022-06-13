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
            @color_array =  ["#624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #9f600c", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", "#e37d26", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", "#c5ac66", " #3ea511", " #C5AC66", " #64ae22", " #c4b645", " #b60762", " #0121e5", " #6e352c", " #5c4d98", " #6c7dea", " #aebd16", " #c941c9", " #872b3b"]
            @default_account = Account.find_by_id(40)
            @default_id = @default_account.id
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

        
    get '/search' do 
        note_hash = Note.index_content
        addendum_hash = Addendum.index_content
        entry_hash = Entry.index_content
        weblink_hash = Weblink.index_content
        project_hash = Project.index_content
        book_hash = Book.index_content

        @search_word = params[:search_word].downcase
        
        @note_results = note_hash[@search_word]
        @addendum_results = addendum_hash[@search_word]
        @entry_results = entry_hash[@search_word]
        @weblink_results = weblink_hash[@search_word]
        @project_results = project_hash[@search_word]
        @book_results = book_hash[@search_word]

        unless @note_results.nil?
            @note_results.uniq!
        end 
        unless @addendum_results.nil?
            @addendum_results.uniq!
        end 
        unless @entry_results.nil?
            @entry_results.uniq!
        end 
        unless @weblink_results.nil?    
            @weblink_results.uniq!
        end 
        unless @project_results.nil?
            @project_results.uniq!
        end 
        unless @book_results.nil?
            @book_results.uniq!
        end 

        erb :"app/results"
    end 

    get '/redirect_search/note/:search_word/:id' do 
        @note = Note.find(params[:id])
        @search_word = params[:search_word]
        @search_word.upcase!

        if @note.project_id == nil 
            if @note.book_id != nil 
                @book = Book.find_by_id(@note.book_id)
                @note.project_id = @book.project_id
                @note.save
                @project = Project.find_by_id(@note.project_id)

                erb :"books/book"
            else 
                @addendum = Addendum.find_by_id(@note.addendum_id)
                @upnote = Note.find_by_id(@addendum.note_id)
                @project = Project.find_by_id(@upnote.id)
                @note.project_id = @project.id 
                @note.save
            end 
        else  
            @project = Project.find_by_id(@note.project_id)
        end 


        erb :"projects/project_search_result"
        

    end 

      get '/redirect_search/addendum/:search_word/:id' do 
            @note = Note.find(params[:id])
            @search_word = params[:search_word]
            @search_word.upcase!
            @project = Project.find(@note.project_id)

        erb :"projects/project_search_result"
        

    end 



 end 