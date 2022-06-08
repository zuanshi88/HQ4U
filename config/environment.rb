require 'sinatra' 

# ENV['SINATRA_ENV'] ||= "development"
ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_relative '../app/controllers/application_controller.rb'