#!/usr/bin/env ruby

##
## creatable - テーブル定義を読み込んで加工し、テンプレートで出力する
##

require 'yaml'
require 'erb'


##
## メインプログラムを表すクラス
##
## 使い方：
##  main = MainProgram.new()
##  output = main.execute(ARGV)
##  print output if output
##
class MainProgram

  def execute(argv=ARGV)
    # コマンドオプションの解析
    options = _parse_options(ARGV)
    return usage() if options[:help]
    raise "テンプレートが指定されていません。" unless options[:template]

    # データファイルを読み込む。タブ文字は空白に展開する。
    s = ''
    while line = gets()
      s << line.gsub(/([^\t]{8})|([^\t]*)\t/n){[$+].pack("A8")}
    end
    {{*doc = YAML.load(s)*}}

    # 読み込んだデータを加工する
    {{*manipulator = Manipulator.new(doc)*}}
    {{*manipulator.manipulate()*}}

    # テンプレートを読み込んで出力を生成する
    {{*s = File.read(options[:template])*}}
    trim_mode = '>'      # '%>' で終わる行では改行を出力しない
    erb = ERB.new(s, $SAFE, trim_mode)
    {{*context = { 'tables' => doc['tables'] }*}}
    {{*output = _eval_erb(erb, context)*}}
    return output
  end

  private

  ## テンプレートを適用する。
  def _eval_erb(__erb, context)
    # このように ERB#result() だけを実行するメソッドを用意すると、
    # 必要な変数 (この場合なら context) だけをテンプレートに渡し、
    # 不必要なローカル変数は渡さなくてすむようになる。
    return __erb.result(binding())
  end

  ## ヘルプメッセージ
  def usage()
     s = ''
     s << "Usage: ruby creatable.rb [-h] -f template datafile.yaml [...]\n"
     s << "  -h          : ヘルプ\n"
     s << "  -f template : テンプレートのファイル名\n"
     return s
  end

  ## コマンドオプションを解析する
  def _parse_options(argv)
    options = {}
    while argv[0] && argv[0][0] == ?-
      opt = argv.shift
      case opt
      when '-h'        # ヘルプ
        options[:help] = true
      when '-f'        # テンプレート名
        arg = argv.shift
        raise "-f: テンプレート名を指定してください。" unless arg
        options[:template] = arg
      else
        raise "#{opt}: コマンドオプションが間違ってます。"
      end
    end
    return options
  end

end


##
## 定義ファイルから読み込んだデータをチェックし、加工するクラス
##
## 使い方：
##   yaml = YAML.load(file)
##   manipulator = Manipulator.new()
##   manipulator.manipulate(yaml)
##
class Manipulator

  def initialize(doc)
    @defaults = doc['defaults'] || {}
    @tables   = doc['tables']   || []
  end

  ## 定義ファイルから読み込んだデータを操作する
  def manipulate()
    
    # 「カラム名→デフォルトカラム定義」の Hash を作成する
    default_columns = {}
    @defaults['columns'].each do |column|
      colname = column['name']
      raise "カラム名がありません。" unless colname
      raise "#{colname}: カラム名が重複しています。" if default_columns[colname]
      default_columns[colname] = column
    end if @defaults['columns']

    # テーブルのカラムをチェックし値を設定する
    tablenames = {}
    @tables.each do |table|
      tblname = table['name']
      raise "テーブル名がありません。" unless tblname
      raise "#{tblname}: テーブル名が重複しています。" if tablenames[tblname]
      tablenames[tblname] = true
      colnames = {}
      table['columns'].each do |column|
        colname = column['name']
        raise "#{tblname}: カラム名がありません。" unless colname
        raise "#{tblname}.#{colname}: カラム名が重複しています。" if colnames[colname]
        colnames[colname] = true
        {{*# カラムのデフォルト値を設定*}}
        {{*default_column = default_columns[colname]*}}
        {{*default_column.each do |key, val|*}}
          {{*column[key] = val unless column.key?(key)*}}
        {{*end if default_column*}}
        {{*# カラムからテーブルへのリンクを設定*}}
        {{*column['table'] = table*}}
        {{*# 外部キーで参照しているカラムの、データ型とカラム幅をコピーする*}}
        {{*if (ref_column = column['ref']) != nil*}}
          {{*column['type']    = ref_column['type']*}}
          {{*column['width'] ||= ref_column['width']  if ref_column.key?('width')*}}
        {{*end*}}
      end if table['columns']
    end
  end

end


## メインプログラムを実行
main = MainProgram.new
output = main.execute(ARGV)
print output if output
