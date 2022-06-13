class WeblinkController < ApplicationController
    

    "/weblink/<%=@note.project_id%>/<%=@note.id%>/<%=@note.class%>"
         

    post "/weblink/:project_id/*/*" do
        @hash = {title: params[:title], url: params[:url], description: params[:description]} 
        @weblink = Weblink.create(@hash)
        @project = Project.find(params[:project_id])

        if params['splat'][0] =~ /project/
            @project.weblinks << @weblink
        elsif params['splat'][0] =~ /note/
            @weblink.note_id = params['splat'][1]
            @note = Note.find(params['splat'][1])
            @note.weblinks << @weblink
        else params['splat'][0] =~ /addendum/
            @addendum = Addendum.find(params['splat'][1])
            @addendum.weblinks << @weblink
            @note = Note.find(@addendum.note_id)
        end 

        if @note 
            @notes = [@note]
        end 

        erb :"app/display"

    end 

    delete "/weblinks/:project_id/:link_id" do 

        @weblink = Weblink.find_by_id(params[:link_id])
        @project = Project.find_by_id(params[:project_id])
        @person = Account.find_by_id(@project.account_id)
        @weblink.destroy

        erb :"app/display"  

    end 


    post "/weblink/book/:project_id/:book_id" do
        @hash = {title: params[:title], url: params[:url], description: params[:description]} 
        @weblink = Weblink.create(@hash)
        @book = Book.find_by_id(params[:book_id])
        @project = Project.find_by_id(params[:project_id])
        @person = Account.find_by_id(@project.account_id)

        erb :"books/book"

    end 

end 