require './app/controllers/application_controller.rb'
require 'rack/test'
require 'rspec'

#not sure what is going on here... should read something about testing Sinatra Apps
# with RSpec and just go really deep with it.


RSpec.describe 'App' do 
    include Rack::Test::Methods

    def app 
        Sinatra::Application
    end 

    it "gets 200 response from /" do
        get "/"
        expect(last_response.status).to eq 200
    end 

end 