#!/usr/bin/ruby

require 'uri'
require 'xmlrpc/client'

server_uri = URI.parse('http://app.cocolog-nifty.com/t/api')

proxy_host = proxy_port = nil
if ENV.key?('http_proxy')
  proxy = URI.parse(ENV['http_proxy'])
  proxy_host = proxy.host
  proxy_port = proxy.port
end
client = XMLRPC::Client.new(server_uri.host, server_uri.path,
                            server_uri.port,
                            proxy_host, proxy_port)
begin
  result = client.call(ARGV.shift || 'mt.supportedMethods')
  p result
  #=> ["blogger.newPost",
  #    "blogger.editPost",
  #    "blogger.getRecentPosts",
  #    "blogger.getUsersBlogs",
  #    "blogger.getUserInfo",
  #    "blogger.deletePost",
  #    "metaWeblog.getPost",
  #    "metaWeblog.newPost",
  #    "metaWeblog.editPost",
  #    "metaWeblog.getRecentPosts",
  #    "metaWeblog.newMediaObject",
  #    "mt.getCategoryList",
  #    "mt.setPostCategories",
  #    "mt.getPostCategories",
  #    "mt.getTrackbackPings",
  #    "mt.supportedTextFilters",
  #    "mt.getRecentPostTitles",
  #    "mt.publishPost",
  #    "mt.setNextScheduledPost"]
rescue XMLRPC::FaultException => e
  puts "fault #{e.faultCode}: #{e.faultString}"
end
