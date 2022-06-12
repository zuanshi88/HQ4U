class AccountController < ApplicationController
    

            get "/people/new" do 
                
                erb :"people/create"
                
            end 

            post "/people/create" do 
                Account.create(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zipcode: params[:zipcode], photo: params[:photo])
            
                @people = Account.all
            
                erb :"people/people"
            end 


            get '/people' do 
                @people = Account.all
                erb :"people/people"
            end 


            get "/people/:id" do 
                
                @person = Account.find_by_id(params[:id])
                
                
                erb :"people/person"
                
            end 

            get "/person/search" do 

                @search = params[:search]
                account_index = Account.name_index

                @results = account_index[@search.downcase]

                if @results.size == 1 
                    results = @results.first
                    @person = Account.find_by_id(results.id)
                    return erb :"people/person"
                end 
                    
                erb :"people/people"

            end 

            get "/people/:id/edit" do 
                @person = Account.find(params[:id])
                erb :"people/edit_person"
            end 

            delete "/people/:id" do 
                @person = Account.find_by_id(params[:id])
                @person.destroy 
                @people = Account.all
                erb :"people/people"
            end  

            patch "/people/:id/edit" do 
                @person = Account.find(params[:id])
                @person.name = params[:name]
                @person.street_address = params[:street_address]
                @person.city = params[:city]
                @person.state = params[:state]
                @person.zipcode = params[:zipcode]
                @person.photo = params[:photo]
                @person.save

                erb :"people/person"
            end 


            patch "/people/:id/photo" do 
                @person = Account.find(params[:id])
                @person.photo = params[:photo] 
                @person.save 
                
                erb :"people/person"

            end 


            get "/activities/:id" do 
                @person = Account.find(params[:id])

                @activities = @person.activities 

                erb :"activities/activities_personal"
            end 

 end 