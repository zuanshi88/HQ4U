class ActivityController < ApplicationController
    
         
get "/annuals" do
    @activities = Activity.all 

    erb :"app/annuals"
end 
        
        
post "/activity/:id" do
    @person = Account.find_by_id(params[:id].to_i)
    @activity = Activity.create(title: params[:title], description: params[:description], annual: params[:annual])
    @activity.created_at = params[:date]
    @person.activities << @activity
    @person.save
    
    erb :"people/person"

end 

delete "/people/:account_id/delete/:activity_id" do 
    @activity = Activity.find_by_id(params[:activity_id].to_i)
    @activity.destroy 

    @person = Account.find_by_id(params[:account_id].to_i)
    
    erb :"people/person"
end 

end 