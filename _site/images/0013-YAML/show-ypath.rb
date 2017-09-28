#!/usr/bin/env ruby

## Usage: ruby show-ypath.rb ypath datafile.yaml

require 'yaml'
require 'pp'

## YPath パターンを取得する
ypath = ARGV.shift
unless ypath
   $stderr.puts "Usage: show-ypath ypath [file.yaml ...]"
   exit(0)
end

## YAML ファイルを読み込み、ツリーに変換する
str = ARGF.read()
tree = {{*YAML.parse(str)*}}

## ツリーを探索し、ypath にマッチしたノードのパスをすべて表示する
puts "#--- search('#{ypath}') ---"
paths = {{*tree.search(ypath)*}}    # paths はパスの配列
paths.each do |path|
  pp path
end

## ツリーを探索し、ypath にマッチしたノードをすべて表示する
puts "#--- select('#{ypath}') ---"
nodes = {{*tree.select(ypath)*}}    # nodes はノードの配列
nodes.each do |node|
  obj = {{*node.transform*}}    # ノードをオブジェクトに変換する
  pp obj
end
## または
# objs = {{*tree.select!(ypath)*}}
# objs.each do |obj|
#   pp obj
# end
