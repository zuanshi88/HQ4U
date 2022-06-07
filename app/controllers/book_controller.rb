class BookController < Sinatra::Base
    
       set :views, "app/views"
       set :public_folder, "public"

        before do 
    
             @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]

         end 


    get "/test" do
         "This is the BOOKS test!!!"
    end 


post '/project/:project_id/book/:book_id/photo/create' do
    @photo = Photo.create(title: params[:title], photo: params[:photo], description: params[:description])
    @book = Book.find(params[:book_id])
    @book.photos << @photo 
    @project = Project.find(params[:project_id])

    erb :"books/book"

end 


post '/project/:project_id/book/:book_id/quote/create' do
    @quote = Quote.create(text: params[:text], author: params[:author], source: params[:source])
    @book = Book.find(params[:book_id])
    @book.quotes << @quote
    @project = Project.find(params[:project_id])

    erb :"books/book"

end 


post '/project/:project_id/book/:book_id/quote/:quote_id/delete' do
    @quote = Quote.find(params[:quote_id])
    @quote.destroy 

    erb :"books/book" 

end 



get '/project/:project_id/book/:book_id/edit_notes_and_quotes' do 
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])
    @person = Account.find(@project.account_id)

    erb :"books/book_edit_notes_and_quotes"


end 

post '/project/:project_id/book/:book_id/weblink/create' do 
    @weblink = Weblink.create(title: params[:title], url: params[:url], description: params[:description])
    @book = Book.find(params[:book_id])
    @book.weblinks << @weblink 

    erb :"books/book"

end 


delete '/project/:project_id/book/:book_id/weblink/:weblink_id/delete' do 
    @weblink = Weblink.find(params[:weblink_id])
    @weblink.destroy 
    @book = Book.find(params[:book_id])

    erb :"books/book" 

end 

end