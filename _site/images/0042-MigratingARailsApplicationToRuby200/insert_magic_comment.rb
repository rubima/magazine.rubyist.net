#! /usr/bin/env ruby
# coding: utf-8
# https://gist.github.com/mrkn/5173137

def has_magic_comment?(content)
  if content.lines.first =~ /\A#!/
    first_line = content.lines.take(2).last
  else
    first_line = content.lines.first
  end
  comment = first_line.sub(/(?:\"(?:[^"]|\\\")*\"|\'(?:[^']|\\\')*\'|[^#]*)#/, '').strip
  comment =~ /\b(?:en)?coding\s*:\s*(?:utf|UTF)-?8\b/
end

def insert_magic_comment(path)
  content = open(path, 'rb') {|io| io.read } rescue $!
  return if Exception === content || content.empty?
  content.force_encoding('BINARY') if content.respond_to?(:force_encoding)
  unless has_magic_comment?(content)
    if content =~ /[^\x00-\x7E]/m
      $stderr.puts "inserting magic comment to #{path}"
      open(path, 'wb') do |io|
        io.puts "# coding: utf-8"
        io.write content
      end
    end
  end
end

if ARGV[0] == '--pre-commit'
  open("|git diff --cached --name-only HEAD") do |io|
    while path = io.gets
      path.strip!
      next unless path =~ /\.rb$/
      insert_magic_comment(path)
    end
  end
else
  require 'find'
  Find.find(Dir.pwd) do |path|
    next unless path =~ /\.rb$/
    insert_magic_comment(path)
  end
end
