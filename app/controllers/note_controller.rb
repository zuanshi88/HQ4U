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

    post "/note/book/:project_id/:book_id" do 
        @project = Project.find_by_id(params[:project_id])
        @book = Book.find_by_id(params[:book_id])
        @note = Note.create(comment: params[:comment])
        @book.notes << @note
        @book.save
        @person = Account.find_by_id(@project.account_id)

        erb :"books/book"
    end 

    delete "/note/:project_id/:note_id" do
        @note = Note.find_by_id(params[:note_id])

        if @note.book_id
            @book = Book.find_by_id(@note.book_id)
            @book_id = true
        end 

        @note.destroy
    
        @project = Project.find_by_id(params[:project_id])

        if @book_id 
            erb :"books/book"
        else
             erb :"projects/project"
        end 

    end 


    get '/open_file/:note_id' do 
        @note = Note.find_by_id(params[:note_id])
        @note.open_file
        @project = Project.find_by_id(@note.project_id)
        erb:"projects/project"
    end 


end 