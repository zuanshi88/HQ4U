require_relative "../app.rb"
require 'rack/test'


RSpec.describe 'App' do 
    include Rack::Test::Methods

    def app 
        App.new
    end 

    it "gets 200 respons from /" do
        get "/"
        expect(last_response.status).to eq 200
    end 

end 