require 'sinatra'
require_relative 'config/environment'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/project_controller'
require_relative 'app/controllers/note_controller'

run ApplicationController
use ProjectController
use NoteController