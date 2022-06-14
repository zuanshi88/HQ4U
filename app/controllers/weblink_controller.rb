class WeblinkController < ApplicationController
    
         

    post "/weblink/create/:project_id/*/*" do
        @hash = {title: params[:title], url: params[:url], description: params[:description]} 
        @weblink = Weblink.create(@hash)
        @project = Project.find(params[:project_id])

        if params['splat'][0] =~ /Project/
            @project.weblinks << @weblink
            @notes = @project.project_notes
        elsif params['splat'][0] =~ /Book/
            @book = Book.find_by_id(params['splat'][1])
            @book.weblinks << @weblink
            @notes = @book.notes
        elsif params['splat'][0] =~ /Note/
            # @weblink.note_id = params['splat'][1]
            @note = Note.find(params['splat'][1])
            @note.weblinks << @weblink
               if @note.book_id != nil 
                @book = Book.find(@note.book_id)
            end 
        else params['splat'][0] =~ /Addendum/
            @addendum = Addendum.find(params['splat'][1])
            @addendum.weblinks << @weblink
            @note = Note.find(@addendum.note_id)
            @open = true
        end 

        if params[:book_id] 
            @book = Book.find(params[:book_id])
        end 


        if @note 
            @notes = [@note]
        end 

        erb :"app/display"

    end 

    delete "/weblinks/delete/:project_id/:link_id/*/*" do 

        @weblink = Weblink.find(params[:link_id])
        @weblink.destroy 

        @project = Project.find(params[:project_id])

        if params['splat'][0] =~ /Project/
            @notes = @project.project_notes
        elsif params['splat'][0] =~ /Book/
            @book = Book.find_by_id(params['splat'][1])
            @notes = @book.notes
        elsif params['splat'][0] =~ /Note/
            @note = Note.find(params['splat'][1])
            if @note.book_id != nil 
                @book = Book.find(@note.book_id)
            end 
        else params['splat'][0] =~ /Addendum/
            @addendum = Addendum.find(params['splat'][1])
            @note = Note.find(@addendum.note_id)
            @open = true
        end 


        if @note 
            @notes = [@note]
        end 

        erb :"app/display"

    end 


end 