class AddendumController < ApplicationController


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

# these routes need to be rewritten for addendums!!!

get "/edit/note/:note_id" do 
        @note = Note.find_by_id(params[:note_id])
        @project = Project.find_by_id(@note.project_id)

        erb :"notes/edit_note"
    end 

    patch "/note/:note_id/:project_id" do 
        @note = Note.find_by_id(params[:note_id])
        @project = Project.find_by_id(params[:project_id])
        @note.comment = params[:comment]
        @note.save 
    
        erb :"projects/project_search_result"
    end 


end