require 'sinatra'
require_relative 'config/environment'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/project_controller'
require_relative 'app/controllers/note_controller'
require_relative 'app/controllers/dictionary_controller'
require_relative 'app/controllers/book_controller'
require_relative 'app/controllers/activity_controller'
require_relative 'app/controllers/photo_controller'
require_relative 'app/controllers/account_controller'
require_relative 'app/controllers/weblink_controller'

use Rack::MethodOverride
run ApplicationController
use ProjectController
use NoteController
use DictionaryController
use BookController
use PhotoController
use AccountController
use ActivityController
use WeblinkController

set :root, File.dirname(__FILE__)