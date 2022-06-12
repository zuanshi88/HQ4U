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


post '/project/:project_id/book/:book_id/note/:note_id/addendum/create' do 
    @addendum = Addendum.create(addition: params[:addition])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])

    @note.addendums << @addendum 

    erb :"books/book" 

end 



post '/project/:project_id/note/:note_id/addendum/create' do 
    @addendum = Addendum.create(addition: params[:addition])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @note.addendums << @addendum 

    erb :"projects/project"

end 


delete '/project/:project_id/note/:note_id/addendum/:addendum_id/delete' do 
    @addendum = Addendum.find(params[:addendum_id])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @addendum.destroy

    erb :"projects/project"
end 

post '/project/:project_id/addendum/:addendum_id/note/create' do 
    @project = Project.find(params[:project_id])
    @note = Note.create(comment: params[:comment], project_id: params[:project_id])
    @addendum = Addendum.find(params[:addendum_id])
    @addendum.notes << @note 


    erb :"projects/project" 
end 


delete '/project/:project_id/addendum/:addendum_id/note/:note_id/delete' do
    @note = Note.find(params[:note_id])
    @note.destroy 
    @project = Project.find(params[:project_id])


    erb :"projects/project"
    

end 


get "/projects/:id" do 
    @person = Account.find_by_id(params[:id].to_i)
    @projects = @person.projects

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

    erb :"projects/project"
end 

get "/project/search_result" do
    @person = Account.find(40)
    @project = Project.find_by_id(30)

    erb :"projects/project_search_result"

end 




end