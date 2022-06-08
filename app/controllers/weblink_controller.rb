class WeblinkController < Sinatra::Base
    
       set :views, "app/views"
       set :public_folder, "public"

        before do 
    
             @color_array = [" #624d60", " #624d60", " #878db5", " #b335a6", " #25a5da", " #919dc5", " #919dc5", " #384f14", " #39ced9", " #fd0fbb", " #b4d36b", " #0b84cc", " #9f600c", " #6246a7", " #6246a7", " #7a8d21", " #688fae", " #44dd7d", " #9c33f6", " #89038b", " #c85ce1", " #2b6e90", " #136888", " #52ebeb", " #29d441", " #98bed7", " #246c06", " #0e8996", " #e37d26", " #2d1521", " #587900", " #44d76b", " #3095b2", " #b58e54", " #4c144a", " #c5ac66", " #62c734", "#62c734", " #3ea511", " #0361b8", " #484346", " #0121e5", " #660b0c", " #660b0c", " #64ae22", " #c4b645", " #56310c", " #6246a7", " #b60762", " #56cd8e", " #482c95", " #6e352c", " #5c4d98", " #5c4d98", " #b8d191", " #9ab838", " #6c7dea", " #5e109b", " #aebd16", " #c941c9", " #872b3b", " #2392c5"]

         end 


         

post "/project/:project_id/*/*/weblink/create" do
    @hash = {title: params[:title], url: params[:url], description: params[:description]} 

        if params['splat'][0] =~ /main/
            @weblink = Weblink.create(@hash)
            @project = Project.find_by_id(params['splat'][1].to_i)
            @project.weblinks << @weblink
            @weblink.save 
            @project.save 

    elsif params['splat'][0] =~ /note/
        @hash[:note_id] = params[:note_id]
        @weblink = Weblink.create(@hash)
        @note = Note.find_by_id(params['splat'][1])
        @note.weblinks << @weblink

    elsif params['splat'][0] =~ /addendum/
        @weblink = Weblink.create(@hash)
        @addendum = Addendum.find_by_id(params['splat'][1])
        @addendum.weblinks << @weblink

    else 
          erb :project
    end 

    @project = @project || Project.find_by_id(params[:project_id])
    @person = Account.find_by_id(@project.account_id)

    erb :"projects/project"


end 

delete "/people/:project_id/weblinks/delete/:link_id" do 
    @weblink = Weblink.find_by_id(params[:link_id])
    @project = Project.find_by_id(params[:project_id])
    @person = Account.find_by_id(@project.account_id)
    @weblink.destroy

    erb :"projects/project"  


end 





        end 