require 'sinatra'
require_relative 'config/environment'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/project_controller'

run ApplicationController
use ProjectController