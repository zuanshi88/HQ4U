require 'sinatra'
require_relative 'config/environment'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/project_controller'
require_relative 'app/controllers/note_controller'
require_relative 'app/controllers/dictionary_controller'
require_relative 'app/controllers/book_controller'

use Rack::MethodOverride
run ApplicationController
use ProjectController
use NoteController
use DictionaryController
use BookController