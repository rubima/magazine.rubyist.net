---
layout: post
title: 0013-CodeReview-recomb.rb
short_title: 0013-CodeReview-recomb.rb
tags: 0013 CodeReview
---


[あなたの Ruby コードを添削します 【第 3 回】 dbf.rb]({% post_url articles/0013/2006-02-20-0013-CodeReview %}) で解説した、添削後のサンプルコードです。

```ruby
#!/usr/local/bin/ruby -Ke
#
# $Id: recomb.rb,v 1.4 2006/02/12 22:05:45 aamine Exp $
#
# 入力dbfファイルから、２つのデフォルトフィールド(日時と雨量)の組を
# 抜き出して指定したフィールドを加え、それらをレコードとするdbfファ
# イルを出力する
# 出力フィールドは、入力リストの先頭ファイルの同名フィールドの定義
# とする。文字型フィールドを出力指定すると、そのいずれか１つでも値
# のないレコードに対しては、レコードを出力しない
# 入力は、コマンドラインで指定したリストファイルを順に読込む。
# 出力は、コマンドラインで指定した出力ファイルに続けて書き込む。
#
# Example:
# ./recomb.rb -f pntid,name,area -o output.dbf input1.dbf input2.dbf
#

require 'dbf'
require 'optparse'

def main
  additional = []
  outfile = nil
  parser = OptionParser.new
  parser.banner = "Usage: #{$0} [-f NAME,NAME...] -o PATH input..."
  parser.on('-f', '--fields=NAME,NAME', 'Adding field names.') {|names|
    additional = names.split(',')
  }
  parser.on('-o', '--output=PATH', 'Name of output file.') {|path|
    outfile = path
  }
  parser.on('--help', 'Prints this message and quit.') {
    puts parser.help
    exit 0
  }
  def parser.error(msg = nil)
    $stderr.puts msg if msg
    $stderr.puts help()
    exit 1
  end
  begin
    parser.parse!
  rescue OptionParser::ParseError => err
    parser.error err.message
  end
  parser.error 'no output file' unless outfile
  parser.error 'no input file' if ARGV.empty?
  infiles = ARGV

  schema_initialized = false
  DBF::RecordSet.open(outfile, 'c') {|dbout|
    infiles.each do |path|
      DBF::RecordSet.open(path, 'r') {|dbin|
        unless schema_initialized
          dbout.add_string_field 'datetime', 20
          dbout.add_numeric_field 'rainfall', 10, 4
          additional.each do |name|
            dbout.add_field dbin.field(name).dup
          end
          schema_initialized = true
        end

        rainfall_data = dbin.fields\
            .select {|field| rainfall_field?(field.name) }\
            .map {|field| [extract_datetime(field.name), field.name] }
        dbin.each_record do |rec|
          next unless valid_record?(rec, additional)
          rainfall_data.each do |datetime, name|
            dbout.append {|r|
              r.datetime = datetime
              r.rainfall = rec[name]
              additional.each do |n|
                r[n] = rec[n]
              end
            }
          end
        end
      }
    end
  }
end

# ALL needed fields must contain non-space chars.
def valid_record?(record, needed_fields)
  needed_fields.map {|name| record.field(name) }\
      .all? {|f| not (f.string_field? and f.value.gsub(/ /, "").empty?) }
end

# Format of rainfall field  e.g. T039250030
RAINFALL_FIELD_RE = /\AT(\d\d)([\da-f])(\d\d)(\d\d)(\d0)\z/

def rainfall_field?(name)
  RAINFALL_FIELD_RE.match(name)
end

# rainfall field name -> datetime string
def extract_datetime(fieldname)
  m = RAINFALL_FIELD_RE.match(fieldname)
  year = m[1]; month = m[2].hex; date = m[3]
  hour = m[4]; minute = m[5]
  "20#{year}/#{month}/#{date} #{hour}:#{minute}:00"
end

main

```


