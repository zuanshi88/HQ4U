require 'sinatra'
require_relative 'config/environment'

Dir.glob('app/controllers/*.rb') { |f| require_relative f }

# leaving this here to illustrate how much typing glob saves!!
# require_relative 'app/controllers/application_controller'
# require_relative 'app/controllers/project_controller'
# require_relative 'app/controllers/note_controller'
# require_relative 'app/controllers/dictionary_controller'
# require_relative 'app/controllers/book_controller'
# require_relative 'app/controllers/activity_controller'
# require_relative 'app/controllers/photo_controller'
# require_relative 'app/controllers/account_controller'
# require_relative 'app/controllers/weblink_controller'

run ApplicationController
use Rack::MethodOverride
use ProjectController
use NoteController
use AddendumController
use DictionaryController
use BookController
use PhotoController
use AccountController
use ActivityController
use WeblinkController


# this set root isn't doing anything, at least its not being used
set :root, File.dirname(__FILE__)