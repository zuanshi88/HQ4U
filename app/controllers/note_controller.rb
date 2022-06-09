class NoteController < ApplicationController
    

    post "/note/:id/:project_id" do 

        @note = Note.create(comment: params[:comment])
        @project = Project.find_by_id(params[:project_id].to_i)
        @project.notes << @note 
        @note.save 
        @project.save 

        @person = Account.find_by_id(params[:id])

        erb :"projects/project"

    end 

    delete "/note/:id/:project_id/:note_id" do
        @note = Note.find_by_id(params[:note_id].to_i)
        @note.destroy
    
        @project = Project.find_by_id(params[:project_id])
        @person = Account.find(params[:id])
        erb :"projects/project"

    end 

    get '/search' do 
        index_hash = Note.index_content
        @search_word = params[:search_word].downcase
        
        @results = index_hash[@search_word]
        @results.uniq!

        erb :"notes/results"
    end 


end 