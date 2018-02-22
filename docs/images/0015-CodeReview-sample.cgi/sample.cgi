#!/usr/bin/ruby
require "tropy"

ABSOLUTE_URL = "http://www.example.com/tropy/sample.cgi"
DATA_FILENAME = "/home/example/www/tropy/data/data.pstore"
MAX_COLS = 80
MAX_ROWS = 20
TITLE = "Tropy"

Tropy::Tropy.new(CGI.new, Tropy::Database.new(DATA_FILENAME))
