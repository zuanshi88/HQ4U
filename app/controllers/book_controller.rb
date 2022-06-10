class BookController < ApplicationController
    


post '/quote/:project_id/:book_id' do
    @quote = Quote.create(text: params[:text], author: params[:author], source: params[:source])
    @book = Book.find(params[:book_id])
    @book.quotes << @quote
    @project = Project.find(params[:project_id])

    erb :"books/book"

end 


delete '/quote/:project_id/:book_id/:quote_id' do
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