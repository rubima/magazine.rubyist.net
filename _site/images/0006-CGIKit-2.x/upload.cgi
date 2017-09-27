#!/usr/local/bin/ruby

require 'cgikit'
require 'UploadPage'
require 'MessagePage'

app = CGIKit::Application.new
app.main = UploadPage
app.run

