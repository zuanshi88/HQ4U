class NoteController < ApplicationController
    

    post "/note/:id/:project_id" do 

        @project = Project.find_by_id(params[:project_id])
        @note = Note.create(comment: params[:comment], project_id: params[:project_id])
        @project.notes << @note 
        @note.save 
        @project.save 

        @person = Account.find_by_id(params[:id])

        erb :"projects/project"

    end 

    post "note/book/:project_id/:book_id" do 
        @project = Project.find_by_id(params[:project_id])
        @book = Book.find_by_id(params[:book_id])
        @note = Note.create(comment: params[:comment], project_id: params[:project_id], book_id: params[:book_id])
        @book.notes << @note
        @book.save
        @person = Account.find_by_id(@project.account_id)

        erb :"books/book"
    end 

    delete "/note/:id/:project_id/:note_id" do
        @note = Note.find_by_id(params[:note_id].to_i)
        @note.destroy
    
        @project = Project.find_by_id(params[:project_id])
        @person = Account.find(params[:id])
        erb :"projects/project"

    end 

    get '/search' do 
        note_hash = Note.index_content
        addendum_hash = Addendum.index_content
        entry_hash = Entry.index_content
        @search_word = params[:search_word].downcase
        
        @note_results = note_hash[@search_word]
        @addendum_results = addendum_hash[@search_word]
        @entry_results = entry_hash[@search_word]
        unless @note_results.nil?
            @note_results.uniq!
        end 
        unless @addendum_results.nil?
            @addendum_results.uniq!
        end 
        unless @entry_results.nil?
            @entry_results.uniq!
        end 

        erb :"notes/results"
    end 

    get '/redirect_search/note/:search_word/:id/:project_id' do 
            @note = Note.find(params[:id])
            unless @note.addendum_id == nil 
                @addendum = Addendum.find(@note.addendum_id)
                @other_note = Note.find(@addendum.note_id)
            end 
            @search_word = params[:search_word]
            @search_word.upcase!
            if params[:project_id] == '0'
                @upnote = Note.find(@addendum.note_id)
                @project = Project.find(@upnote.project_id)
                @note.project_id = @project.id
                @note.save
            else
                @project = Project.find(params[:project_id])
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

    get '/open_file/:note_id' do 
        @note = Note.find_by_id(params[:note_id])
        @note.open_file
        @project = Project.find_by_id(@note.project_id)
        erb:"projects/project"
    end 


end 