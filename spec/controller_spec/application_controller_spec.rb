require './spec_helper'

require './app/controllers/application_controller.rb'
# require './app/models/account.rb'
# require './app/models/activity.rb'


RSpec.describe ApplicationController do 
     include Rack::Test::Methods
     def app 
        ApplicationController
     end 

    it 'has a home page' do
        get '/' 
        expect(last_response).to be_ok    
    end
end 