class NoteController < ApplicationController
    
    
    
    #create PROJECT note
    
    post "/note/project/:project_id/:type" do 
       
        @project = Project.find_by_id(params[:project_id])
        @note = Note.create(comment: params[:comment], project_id: params[:project_id])
        
        if params[:type] != nil 
            @book = param[:type]
            @book.notes << @note
            @notes = @book.notes 
        else
            @project.notes << @note 
            @notes = @project.project_notes
        end 

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

    post '/note/addendum/note/:project_id/:addendum_id' do 

        @project = Project.find(params[:project_id])
        @note = Note.create(comment: params[:comment], project_id: params[:project_id])
        @addendum = Addendum.find(params[:addendum_id])
        @parent_note = Note.find(@addendum.note_id)
        @addendum.notes << @note    

        @notes = [@parent_note]
        @open = true
        @add_open = true

        if @parent_note && @parent_note.book_id != nil 
            @book = Book.find(parent_note.book_id)
            @note.book_id = @book.id
            @note.save
        end 

        erb :"app/display" 
end 

    #edit and update PROJECT note
    
    get "/edit/note/:note_id" do 
        @note = Note.find(params[:note_id])
        @project = Project.find(@note.project_id)

        if @note.book_id != nil
            @book = Book.find(@note.book_id)
        end 

        erb :"notes/edit_note"
    end 

      
    get "/edit/note/addendum/note/:note_id" do 
        @note = Note.find(params[:note_id])
        @project = Project.find(@note.project_id)

        if @note.book_id != nil
            @book = Book.find(@note.book_id)
        end 

        erb :"notes/edit_addendum_note"
    end 


    patch "/note/update/:project_id/:note_id" do 
        @note = Note.find(params[:note_id])
        @project = Project.find(params[:project_id])
        @note.comment = params[:comment]
        @note.save 

         if @note.book_id != nil
            @book = Book.find_by_id(@note.book_id)
         end 

         if @note.addendum_id != nil 
            @open = true
            @add_open = true
         end 

        @notes = [@note]
    
        erb :"app/display"
    end 


    # DELETE PROJECT and Book associated note
    get "/edit/note/addendum/note/:note_id" do 
        @note = Note.find(params[:note_id])
        @project = Project.find(@note.project_id)
      
        if @note.book_id != nil
            @book = Book.find(@note.book_id)
        end 

        erb :"notes/edit_note"
    end 

    patch "/note/addendum/note/update/:project_id/:note_id" do 
        @note = Note.find(params[:note_id])
        @project = Project.find(params[:project_id])
        @addendum = Addendum.find(@note.addendum_id)
        @parent_note = Note.find(@addendum.note_id)
        @note.comment = params[:comment]
        @note.save 

         if @note.book_id != nil
            @book = Book.find(@note.book_id)
         end 

        @open = true
        @add_open = true
    

        @notes = [@parent_note]
    
        erb :"app/display"
    end 



    delete "/note/delete/:project_id/:note_id" do
        @project = Project.find(params[:project_id])
        @note = Note.find(params[:note_id])

        if @note.book_id != nil
            @book = Book.find(@note.book_id)
        end 

        if @note.addendum_id != nil 
            @addendum = Addendum.find(@note.addendum_id)
            @parent_note = Note.find(@addendum.note_id)
        end 


        @note.delete

        
        if @parent_note
            @notes = [@parent_note]
            @open = true 
            @add_open = true 
        elsif @book 
            @notes = @book.notes
        else
            @notes = @project.project_notes
        end 
            erb :"app/display"
    end 

    
    get '/open_file/:note_id' do 
        @note = Note.find_by_id(params[:note_id])
        @note.open_file
        @project = Project.find_by_id(@note.project_id)
        @notes = @project.project_notes
        erb:"projects/project"
    end 


end 