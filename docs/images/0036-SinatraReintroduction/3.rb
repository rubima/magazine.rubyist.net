  require 'rubygems'
  require 'sinatra/base'

  class MyApp < Sinatra::Base
    get '/' do
      'Fly me to the Moon!'
    end
  end

  MyApp.run! :host => 'localhost', :port => 9090
