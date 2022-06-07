class ProjectController < Sinatra::Base


    configure :development do
        set :views, "app/views"
        set :public_folder, "public"
    end

    post "/project/:id" do 
        @project = Project.create(title: params[:title], description: params[:description])
        @note = Note.create(comment: "another auspicious beginning!")
        @project.notes << @note 
        @person = Account.find_by_id(params[:id].to_i)
        @person.projects << @project 
        @person.save

        erb :person
    end 

end