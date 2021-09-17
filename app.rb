require "sinatra"
require_relative "model/person.rb"


@shadowman = "Shadowman"



get "/" do
    @shadowman = "Shadowman"
    params[:directory] = ["Tom", "Dick", "Harry"]
	erb :home
end




get "/new" do 
    
    erb :new
    
end 

get '/people' do 
    params[:people] = @people 
    
    erb :people 
end 

get "/people/:id" do 

    erb :person
 
end 

post "/new" do 
    params[:person] = Person.new(params[:name], params[:street_address], params[:city], params[:state], params[:zip_code])
    
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