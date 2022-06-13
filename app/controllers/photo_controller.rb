class PhotoController < ApplicationController
    
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

            @notes = @project.project_notes

            erb :"projects/project"

        end


        get "/photoroom/:id" do 
            @project = Project.all.find_by_id(params[:id])
            @person = Account.find(@project.account_id)

            erb :"photos/photoroom"

        end 

        get "/photoroom/book/:id" do
            @book = Book.find_by_id(params[:id]) 
            @project = Project.find(@book.project_id)

            erb :"photos/photoroom_book" 

        end 

        get "/photoroom/book/edit/:id" do 
            @book = Book.find(params[:id])
            @project = Project.find(@book.project_id)

            erb :"photos/photoroom_book_edit"

        end 

        post '/photo/book/:project_id/:book_id' do
            @photo = Photo.create(title: params[:title], photo: params[:photo], description: params[:description])
            @book = Book.find(params[:book_id])
            @book.photos << @photo 
            @project = Project.find(params[:project_id])

            erb :"books/book"

        end 


end 