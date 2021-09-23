require "sinatra"
require "sinatra/activerecord"
require_relative "model/person.rb"
require_relative "model/account.rb"
require_relative "model/agendaday.rb"
require_relative "model/activity.rb"

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

get "/people/create" do 
    
    erb :create
    
end 

post "/people/new" do 
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

post "/people/:id/activity/new" do
    @person = Account.find_by_id(params[:id])
    @person.activities << Activity.create(title: params[:title], description: params[:description])
    @person.save

    erb :person

end 


get '/people/all/touch_points' do 
    erb :touch_points
end 


get "/people/:id/add_touch_point" do 
    
    erb :add_touch_point
    
end 

post "/people/:id/add_touch_point" do 

    Person.people[params[:id].to_i].add_touch_point(params[:time_date], params[:notes])

    erb :person 
end 






get "/about" do
	erb :about
end

get '/meetings' do 
    erb :meetings
end 