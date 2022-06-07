class ProjectController < Sinatra::Base

    get '/test' do 
        "You passed the test!"
    end 

    post "/people/:id/project/create" do 
        @project = Project.create(title: params[:title], description: params[:description])
        @note = Note.create(comment: "another auspicious beginning!")
        @project.notes << @note 
        @person = Account.find_by_id(params[:id].to_i)
        @person.projects << @project 
        @person.save

        erb :person
    end 

end