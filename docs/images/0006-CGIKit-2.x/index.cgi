#!/usr/local/bin/ruby
require 'cgikit'
require 'AlbumPage'

app = CGIKit::Application.new
app.main = AlbumPage
app.web_server_resources = './image' ; app.document_root = './'
app.run

