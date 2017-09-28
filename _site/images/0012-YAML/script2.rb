## Kwalify::Parse を使って YAML ドキュメントを読み込む。
## (このパーサは行番号を保持している。)
str = ARGF.read()
{{*parser = Kwalify::Parser.new(str)*}}
{{*document = parser.parse()*}}

## スキーマファイルを読み込み (これは Syck を使ってもよい)、
## バリデータを作成して検証する。
schema = YAML.load_file('schema.yaml')
{{*validator = Kwalify::Validator.new(schema)*}}
{{*errors = validator.validate(document)*}}

## エラーがあれば、行番号を設定して表示する。
## 行番号を設定するには、Kwalify::Parser が必要。
if !errors || errors.empty?
  puts "valid."
else
  {{*parser.set_errors_linenum(errors)*}}        # YPath をもとに行番号を設定
  errors.sort.each do |err|                # 行番号でソートし、表示する
    print "line %d: path %s: %s" % [err.linenum, err.path, err.message]
  end
end
