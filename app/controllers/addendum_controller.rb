class AddendumController < ApplicationController
    
    
    post '/addendum/:note_id' do 
        @addendum = Addendum.create(addition: params[:addition])
        @note = Note.find(params[:note_id])
        @project = Project.find(@note.project_id)
        @note.addendums << @addendum 
        @project.touch

        @notes = [@note]
        @open = true

        if @note.book_id != nil
            @book = Book.find(@note.book_id)
        end 

        erb :"app/display"

    end 


    delete '/addendum/:addendum_id' do 
        @addendum = Addendum.find(params[:addendum_id])
        @note = Note.find(@addendum.note_id)
        @project = Project.find(@note.project_id)

        @addendum.destroy

        @notes = [@note]
        @open = true

        if @note.book_id != nil
            @book = Book.find(@note.book_id)
        end 

        erb :"app/display"
    end 


    get "/addendum/edit/:addendum_id" do 
            @addendum = Addendum.find(params[:addendum_id])
            @note = Note.find(@addendum.note_id)
            @project = Project.find(@note.project_id)

            if @note.book_id != nil
                @book = Book.find(@note.book_id)
            end 

            erb :"addendums/edit_addendum"
        end 

    patch "/addendum/update/:addendum_id" do 
            @addendum = Addendum.find(params[:addendum_id])
            @note = Note.find(@addendum.note_id)
            @project = Project.find(@note.project_id)
            @addendum.addition = params[:addition]
            @addendum.save 

            if @note.book_id != nil
                @book = Book.find(@note.book_id)
            end 

            @notes = [@note]
            @open = true
        
            erb :"app/display"
        end 

        get "/addendum/:addendum_id" do 
            @addendum = Addendum.find(params[:addendum_id])
            @note = Note.find(@addendum.note_id)
            @project = Project.find(@note.project_id)

            if @note.book_id != nil
                @book = Book.find(@note.book_id)
            end 
            @addendum.touch
            @notes = [@note]
            @open = true
        
            erb :"app/display"

        end 




end