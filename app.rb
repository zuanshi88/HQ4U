require "sinatra"
require "sinatra/activerecord"
require_relative "model/person.rb"
require_relative "model/account.rb"
require_relative "model/agendaday.rb"
require_relative "model/activity.rb"
require_relative "model/project.rb"
require_relative "model/note.rb"

set :database, {adapter: "sqlite3", database: "crm.sqlite3"}

# require_relative "model/directory.rb"


# include Address_Book_Module


@shadowman = "Shadowman"
# @entries_file = "./data/database.txt"

# @database = Directory.new(@entries_file)

def marshal_save(obj_array, file)
  File.open(file, "wb"){|f| f.write(Marshal.dump(obj_array))}
end


get "/" do

	erb :home, :locals => {:local_a => @insult, :local_b => "you, motherfucker!!!"}
end


get "/params/:name/:adj/:insult" do 
    erb :params 
end 

get "/people/new" do 
    
    erb :create
    
end 

post "/people/create" do 
    Account.create(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zipcode: params[:zipcode], photo: params[:photo])
  
    @people = Account.all
   
    erb :people
end 


get '/people' do 
    @people = Account.all
    erb :people 
end 


get "/people/:id" do 
    
    @person = Account.find_by_id(params[:id])
    
    erb :person
    
end 

get "/people/:id/edit_contact" do 
    @person = Account.find(params[:id])
    erb :edit_person
end 

delete "/people/:id" do 
    @person = Account.find_by_id(params[:id])
    @person.destroy 
    @people = Account.all
    erb :people
end  

patch "/people/:id/edit" do 
    @person = Account.find(params[:id])
    @person.name = params[:name]
    @person.street_address = params[:street_address]
    @person.city = params[:city]
    @person.state = params[:state]
    @person.zipcode = params[:zipcode]
    @person.save

    erb :person
end 


patch "/people/:id/photo" do 
    @person = Account.find(params[:id])
    @person.photo = params[:photo] 
    @person.save 
    
    erb :person 


end 

get "/secret" do 
    erb :secret
end 

post "/people/:id/activity/create" do
    @person = Account.find_by_id(params[:id].to_i)
    @person.activities << Activity.create(title: params[:title], description: params[:description])
    @person.save

    erb :person

end 

delete "/people/:account_id/delete/:activity_id" do 
    @activity = Activity.find_by_id(params[:activity_id].to_i)
    @activity.destroy 

    @person = Account.find_by_id(params[:account_id].to_i)
    
    erb :person
end 

post "/people/:id/project/create" do 
    @project = Project.create(title: params[:title], description: params[:description])
    @person = Account.find_by_id(params[:id].to_i)
    @person.projects << @project 
    @person.save
    @person.save

    erb :person

end 

get "/people/:account_id/project/:project_id" do 
    @project = Project.find_by_id(params[:project_id].to_i)

    erb :project 

end 

delete "/people/:account_id/project/delete/:project_id" do 
      @project = Project.find_by_id(params[:project_id].to_i)
      @project.destroy

      @person = Account.find_by_id(params[:account_id].to_i)

      erb :person 
end 

post "/people/:id/project/:project_id/note/create" do 

    @note = Note.create(comment: params[:comment])
    @project = Project.find_by_id(params[:project_id].to_i)
    @project.notes << @note 
    @note.save 
    @project.save 

    @person = Account.find_by_id(params[:id])

    erb :project


end 




get "/about" do
	erb :about
end

get '/meetings' do 
    erb :meetings
end 