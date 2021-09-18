require "sinatra"
require_relative "model/person.rb"
# require_relative "model/directory.rb"


# include Address_Book_Module


@shadowman = "Shadowman"
# @entries_file = "./data/database.txt"

# @database = Directory.new(@entries_file)

def marshal_save(obj_array, file)
  File.open(file, "wb"){|f| f.write(Marshal.dump(obj_array))}
end


get "/" do
    @shadowman = "Shadowman"
    params[:directory] = ["Tom", "Dick", "Harry"]
	erb :home
end




get "/people/create" do 
    
    erb :create
    
end 



get '/people' do 
    # params[:directory] = Directory.new(@entries_file)
    # params[:people] = @people 
    
    erb :people 
end 

get '/people/all/touch_points' do 
    erb :touch_points
end 

get "/people/:id" do 

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
    erb :edit_person
end 

# post "/people/:id/edit_contact" do 
#     Person.people[[params[:id].to_i].update(params(update_values))
#     #param_values are a has of updated values. 
#     #Update expects a has of values. Will replace all keys.
#     #Keep all values as default.
# end 


post "/people/new" do 
    params[:person] = Person.new(params[:name], params[:street_address], params[:city], params[:state], params[:zip_code], params[:photo])
    # directory = Directory.new("./data/database.txt")
    
    # marshal_save(directory, @entries_file)
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