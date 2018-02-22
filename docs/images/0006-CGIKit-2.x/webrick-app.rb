#!/usr/bin/env ruby
require 'webrick'
require 'cgikit'
require 'cgikit/webrick'
require 'UploadPage'
require 'MessagePage'
require 'AlbumPage'

port = (ARGV.shift || 8080).to_i

app = CGIKit::Application.new
app.main = UploadPage
app2 = CGIKit::Application.new
app2.main = AlbumPage
app2.web_server_resources = './image'; app2.document_root = './'
server = WEBrick::HTTPServer.new({:Port => port})
server.mount('/upload.cgi', WEBrick::CGIKitServlet::ApplicationHandler, app)
server.mount('/', WEBrick::CGIKitServlet::ApplicationHandler, app2)
server.mount('/image', WEBrick::HTTPServlet::FileHandler, './image')

trap("INT"){ server.shutdown }
server.start
