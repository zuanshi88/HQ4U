class ProjectController < ApplicationController


    post "/projects/:id" do 
        @project = Project.create(title: params[:title], description: params[:description])
        @note = Note.create(comment: "another auspicious beginning!")
        @project.notes << @note 
        @person = Account.find_by_id(params[:id].to_i)
        @person.projects << @project 
        @person.save

        erb :"people/person"
    end 

# cut from line 226 in application controller

    delete '/projects/:project_id' do 
        @project = Project.find_by_id(params[:project_id])
        @person = Account.find_by_id(@project.account_id)
        @project.destroy

        erb :"people/person" 
    end 

get "/projects/:id" do 
    
    @projects = Project.all

    @projects = @projects.sort_by{|p| p.updated_at }

    # @notes = @project.project_notes

    erb :"projects/projects"  
end 

post "/people/:id/project/create" do 
    @project = Project.create(title: params[:title], description: params[:description])
    @note = Note.create(comment: "another auspicious beginning!")
    @project.notes << @note 
    @person = Account.find_by_id(params[:id].to_i)
    @person.projects << @project 
    @person.save

    erb :"people/person"

end 


get "/project/:account_id/:project_id" do 
    @project = Project.find_by_id(params[:project_id])
    @person = Account.find(params[:account_id])

    @notes = @project.project_notes

    erb :"app/display"
end 

end