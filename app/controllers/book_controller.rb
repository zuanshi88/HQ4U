class BookController < ApplicationController
    

    #display book

get '/books' do

    erb :"books/books"
end 

get '/book/:project_id/:book_id' do 
    @project = Project.find(params[:project_id])
    @book = Book.find(params[:book_id])
    @person = Account.find(@project.account_id)

    erb :"books/book"

end 

#create book

post '/book/:project_id' do

    @book = Book.create(title: params[:title], author: params[:author], synopsis: params[:synopsis], pages: params[:pages])
    @project = Project.find(params[:project_id])
    @person = Account.find(@project.account_id)
    @project.books << @book
    
    @notes = @project.project_notes
    
    erb :"projects/project"

end 

delete '/book/:book_id' do 
    @book = Book.find_by_id(params[:book_id])
    @book.destroy

    erb :"/books/books"

end 



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



get '/edit_notes_and_quotes/:project_id/:book_id' do 
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