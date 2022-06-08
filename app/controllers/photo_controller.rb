class PhotoController < Sinatra::Base
    
       set :views, "app/views"
       set :public_folder, "public"

        before do 
    
             @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]

         end 


         delete '/project/:project_id/book/:book_id/photo/:photo_id/delete' do
    @photo = Photo.find(params[:photo_id])
    @photo.destroy 
    @book = Book.find(params[:book_id])
    @project = Project.find(params[:project_id])

    erb :"photos/photoroom_book_edit"

end 


post "/people/:id/project/:project_id/photo" do
    @photo = Photo.create(title: params[:title], photo: params[:photo], description: params[:description])
    @project = Project.find(params[:project_id])
    @project.photos << @photo 
    @project.save
    @person = Account.find(@project.account_id)

    erb :"projects/project"

end


get "/photoroom/:id" do 
    @project = Project.all.find_by_id(params[:id])
    @person = Account.find(@project.account_id)

    erb :"photos/photoroom"

end 

get "/photoroom/book/:id" do
    @book = Book.find(params[:id]) 
    @project = Project.find(@book.project_id)

    erb :"photos/photoroom_book" 

end 

get "/photoroom/book/edit/:id" do 
    @book = Book.find(params[:id])
    @project = Project.find(@book.project_id)

    erb :"photos/photoroom_book_edit"

end 





        end 