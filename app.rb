require "sinatra"
require "sinatra/activerecord"
require_relative "model/person.rb"
require_relative "model/account.rb"

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
  
	erb :home
end




get "/people/create" do 
    
    erb :create
    
end 



get '/people' do 
  
    @people = Account.all

    erb :people 
end 

get '/people/all/touch_points' do 
    erb :touch_points
end 

get "/people/:id" do 

    @person = Account.find_by_id(params[:id])

    erb :person
 
end 

get "/secret" do 
    erb :secret
end 

get "/people/:id/add_touch_point" do 

    erb :add_touch_point

end 

post "/people/:id/add_touch_point" do 

    Person.people[params[:id].to_i].add_touch_point(params[:time_date], params[:notes])

    erb :person 
end 

get "/people/:id/edit_contact" do 
    @person = Account.find(params[:id])
    erb :edit_person
end 

get "/people/delete/:id" do 
    @person = Account.find_by_id(params[:id])
    @person.destroy 

    @shi_face = "SHit Face"
    erb :people
end  

put "/people/:id" do 
    @person = Account.find(params[:id])
    @person.update(params[:people])

    erb :person
end 

# post "/people/:id/edit_contact" do 
#     Person.people[[params[:id].to_i].update(params(update_values))
#     #param_values are a has of updated values. 
#     #Update expects a has of values. Will replace all keys.
#     #Keep all values as default.
# end 


post "/people/new" do 
    Account.create(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zipcode: params[:zipcode])
  
    @people = Account.all
   
    erb :people
end 


get "/about" do
	erb :about
end

# get "/person/:name" do 
#     @@people.select do |person|
#         person.name == name 
#     end.first

#     erb :person
# end 