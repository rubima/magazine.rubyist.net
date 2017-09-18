#!/usr/bin/env ruby
require 'webrick'
require 'cgikit'
require 'cgikit/webrick'
require 'UploadPage'

port = (ARGV.shift || 8080).to_i

app = CGIKit::Application.new
app.main = UploadPage
server = WEBrick::HTTPServer.new({:Port => port})
server.mount('/upload.cgi', WEBrick::CGIKitServlet::ApplicationHandler, app)

trap("INT"){ server.shutdown }
server.start
