class AddendumController < ApplicationController
    
    
post '/addendum/*/:project_id/:note_id' do 
    @addendum = Addendum.create(addition: params[:addition])
    @note = Note.find(params[:note_id])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @note.addendums << @addendum 

    @notes = [@note]

     if params['splat'][0] == 'book'
        @book = Book.find(@note.book_id)
    end 

    erb :"app/display"

end 


delete '/addendum/*/:note_id/:addendum_id' do 
    @addendum = Addendum.find(params[:addendum_id])
    @note = Note.find(params[:note_id])
    @project = Project.find(@note.project_id)
    @person = Account.find(@project.account_id)
    @addendum.destroy

    @notes = [@note]

    if params['splat'][0] == 'book'
        @book = Book.find(@note.book_id)
    end 

    erb :"app/display"
end 

# fix this addendum/note creation



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
    
        @notes = [@note]
        
        erb :"app/display"
    end 

    # creat addendum for book addendum
    
    post '/addendum/:project_id/book/:book_id/note/:note_id/create' do 
        @addendum = Addendum.create(addition: params[:addition])
        @note = Note.find(params[:note_id])
        @project = Project.find(params[:project_id])
        @book = Book.find(params[:book_id])

        @note.addendums << @addendum 

        erb :"books/book" 

    end 



end