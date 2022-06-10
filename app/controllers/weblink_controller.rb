class WeblinkController < ApplicationController
    

         

    post "/project/:project_id/*/*/weblink/create" do
        @hash = {title: params[:title], url: params[:url], description: params[:description]} 

            if params['splat'][0] =~ /main/
                @weblink = Weblink.create(@hash)
                @project = Project.find_by_id(params['splat'][1].to_i)
                @project.weblinks << @weblink
                @weblink.save 
                @project.save 

        elsif params['splat'][0] =~ /note/
            @hash[:note_id] = params[:note_id]
            @weblink = Weblink.create(@hash)
            @note = Note.find_by_id(params['splat'][1])
            @note.weblinks << @weblink

        elsif params['splat'][0] =~ /addendum/
            @weblink = Weblink.create(@hash)
            @addendum = Addendum.find_by_id(params['splat'][1])
            @addendum.weblinks << @weblink

        else 
            erb :project
        end 

        @project = @project || Project.find_by_id(params[:project_id])
        @person = Account.find_by_id(@project.account_id)

        erb :"projects/project"


    end 

    delete "/people/:project_id/weblinks/delete/:link_id" do 
        @weblink = Weblink.find_by_id(params[:link_id])
        @project = Project.find_by_id(params[:project_id])
        @person = Account.find_by_id(@project.account_id)
        @weblink.destroy

        erb :"projects/project"  


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