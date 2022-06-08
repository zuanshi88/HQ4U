class ProjectController < ApplicationController


    post "/projects/:id" do 
        @project = Project.create(title: params[:title], description: params[:description])
        @note = Note.create(comment: "another auspicious beginning!")
        @project.notes << @note 
        @person = Account.find_by_id(params[:id].to_i)
        @person.projects << @project 
        @person.save

        erb :person
    end 

# cut from line 226 in application controller

    delete '/projects/:account_id/:project_id' do 
        @project = Project.find_by_id(params[:project_id].to_i)
        @project.destroy

        @person = Account.find_by_id(params[:account_id].to_i)

        erb :person 
    end 


post '/project/:project_id/book/create' do

    @book = Book.create(title: params[:title], author: params[:author], synopsis: params[:synopsis], pages: params[:pages])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @project.books << @book
    
    
    erb :"projects/project"

end 

get '/project/:project_id/book/:book_id' do 
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])
    @person = Account.find(@project.account_id)

    erb :"books/book"

end 


post '/project/:project_id/book/:book_id/note/create' do
    @note = Note.create(comment: params[:comment])
    @book = Book.find(params[:book_id])
    @book.notes << @note 
    @project = Project.find(params[:project_id])
    @person = @project.account_id

    erb :"books/book"

end 

delete '/project/:project_id/book/:book_id/note/:note_id/delete' do
    @note = Note.find(*params[:note_id])
    @note.destroy 
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @book = Book.find(params[:book_id])

    erb :"books/book_edit_notes_and_quotes"
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
    @note = Note.create(comment: params[:comment])
    @addendum = Addendum.find(params[:addendum_id])
    @addendum.notes << @note 

    @project = Project.find(params[:project_id])

    erb :"projects/project" 
end 


delete '/project/:project_id/addendum/:addendum_id/note/:note_id/delete' do
    @note = Note.find(params[:note_id])
    @note.destroy 
    @project = Project.find(params[:project_id])


    erb :"projects/project"
    

end 


get "/people/:id/projects" do 
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


get "/people/:id/project/:p_id" do 
    @project = Project.find_by_id(params[:p_id])
    @person = Account.find(params[:id])

    erb :"projects/project"
end 




end