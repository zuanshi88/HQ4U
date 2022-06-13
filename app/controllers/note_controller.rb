class NoteController < ApplicationController
    
    
    
    #create PROJECT note
    
    post "/note/project/:project_id" do 
        
        @project = Project.find_by_id(params[:project_id])
        @note = Note.create(comment: params[:comment], project_id: params[:project_id])
        @project.notes << @note 
        @project.save 
        
        @notes = @project.project_notes
        
        erb :"projects/project"
        
    end 
    
    post "/note/book/:project_id/:book_id" do 
        @project = Project.find_by_id(params[:project_id])
        @book = Book.find_by_id(params[:book_id])
        @note = Note.create(comment: params[:comment], project_id: @book.project_id)
        @book.notes << @note
        @book.save
        @person = Account.find_by_id(@project.account_id)
    
        erb :"books/book"
    end 

    post '/note/addendum/:project_id/:addendum_id/*' do 

    @project = Project.find(params[:project_id])
    @note = Note.create(comment: params[:comment], project_id: params[:project_id])
    @addendum = Addendum.find(params[:addendum_id])
    parent_note = Note.find(@addendum.note_id)
    @addendum.notes << @note    

    @notes = [@note]

    if params['splat'][0] == 'book'
        @book = Book.find(parent_note.book_id)
        @note.book_id = @book.id
        @note.save
    end 

    erb :"app/display" 
end 

    #edit and update PROJECT note
    
    get "/edit/note/:note_id" do 
        @note = Note.find_by_id(params[:note_id])
        @project = Project.find_by_id(@note.project_id)

        if @note.book_id != nil
            @book = Book.find_by_id(@note.book_id)
        end 

        erb :"notes/edit_note"
    end 

    patch "/note/:note_id/:project_id" do 
        @note = Note.find_by_id(params[:note_id])
        @project = Project.find_by_id(params[:project_id])
        @note.comment = params[:comment]
        @note.save 

         if @note.book_id != nil
            @book = Book.find_by_id(@note.book_id)
         end 

        @notes = [@note]
    
        erb :"app/display"
    end 


    # DELETE PROJECT and Book associated note
    

    delete "/note/:project_id/:note_id" do
        @project = Project.find_by_id(params[:project_id])
        @note = Note.find_by_id(params[:note_id])

        if @note.book_id != nil
            @book = Book.find_by_id(@note.book_id)
        end 

        @note.delete
        @project.save

    
        if @book 
            @notes = @book.notes
            erb :"books/book"
        else
            @notes = @project.project_notes

            erb :"/projects/project"
        end 

    end 


    #----------------------------------------------------------

    #create ADDENDUM NESTED for note 

    



    #delete addendum nested noteparent_note = Note.find(@addendum.note_id)

     delete '/note/*/addendum/note/:addendum_id/:note_id' do
        @addendum = Addendum.find(params[:addendum_id])
        parent_note = Note.find(@addendum.note_id)
        @note = Note.find(params[:note_id])
        @note.delete
        @project = Project.find(parent_note.project_id)
    
        @notes = [parent_note]

        if params['splat'][0] == 'book'
            @book = Book.find(parent_note.book_id)
        end 
    
        erb :"app/display"
    
    end 

#-------------------------------------------------

    #create BOOK associated note


    




    get '/open_file/:note_id' do 
        @note = Note.find_by_id(params[:note_id])
        @note.open_file
        @project = Project.find_by_id(@note.project_id)
        @notes = @project.project_notes
        erb:"projects/project"
    end 


end 