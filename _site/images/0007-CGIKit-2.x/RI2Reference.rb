#!/usr/local/bin/ruby

# RI2Reference.rb [port]

$LOAD_PATH.unshift('lib')
require 'webrick'
require 'cgikit-all'
require 'cgikit/webrick'
require 'application'
require 'directaction'

port = (ARGV.shift || 8080).to_i

app = RI2Reference::Application.new
app.load_all_components('./components')
app.load_configuration('./cgikitconf.rb')

app.direct_action_class = RI2Reference::DirectAction
app.default_request_handler = app.direct_action_request_handler

server = WEBrick::HTTPServer.new({:Port => port})
server.mount('/', WEBrick::CGIKitServlet::ApplicationHandler, app)
server.mount('/www', WEBrick::HTTPServlet::FileHandler, './www')

trap("INT"){ server.shutdown }
server.start
