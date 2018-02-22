#!/usr/bin/ruby

# Registration.rb [port]

$LOAD_PATH.unshift('lib')
require 'webrick'
require 'cgikit'
require 'cgikit/webrick'
require 'application'
require 'session'
require 'directaction'
require 'kconv'

module Registration
  
  module UserInfo
    attr_accessor :name, :age, :sex, :year, :month, :day, :address, :phone
    
    def to_utf8
      @name = Kconv.toutf8(@name)
      @age = Kconv.toutf8(@age)
      @sex = Kconv.toutf8(@sex)
      @year = Kconv.toutf8(@year)
      @month = Kconv.toutf8(@month)
      @day = Kconv.toutf8(@day)
      @address = Kconv.toutf8(@address)
      @phone = Kconv.toutf8(@phone)
    end    
  end
  
  def self.copy_info(from, to)
    to.name = from.name
    to.age = from.age
    to.sex = from.sex
    to.year = from.year
    to.month = from.month
    to.day = from.day
    to.address = from.address
    to.phone = from.phone
  end
  
end


port = (ARGV.shift || 8080).to_i

app = Registration::Application.new
app.load_all_components('./components')
app.load_configuration('./cgikitconf.rb')
app.main = Registration::RegisterPage

server = WEBrick::HTTPServer.new({:Port => port})
server.mount('/', WEBrick::HTTPServlet::FileHandler, "www")
server.mount('/register.cgi', WEBrick::CGIKitServlet::ApplicationHandler, app)

trap("INT"){ server.shutdown }
server.start
