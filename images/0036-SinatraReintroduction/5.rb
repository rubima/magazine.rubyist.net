  # encoding: utf-8
  require 'rubygems'
  require 'sinatra/base'

  require 'haml'

  class App < Sinatra::Base
    enable :inline_templates
    get '/' do
      @title = "Top"
      haml "My Way"
    end

    get '/name/:name' do
      @name = params[:name]
      @title = "Song for #{@name}"
      haml "#{@name}'s Way"
    end
  end

  App.run!

  __END__

  @@ layout
  !!! 5
  %html
   %head
    %title= @title
   %body
    %h1= @title
    %div= yield
