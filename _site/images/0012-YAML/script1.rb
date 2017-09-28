require 'kwalify'

## スキーマファイルを読み込み、バリデータを作成する。
## スキーマ定義にエラーがあると、例外 Kwalify::SchemaError が発生する。
schema = YAML.load_file('schema.yaml')
{{*validator = Kwalify::Validator.new(schema)*}}

## YAML ドキュメントを読み込み、バリデータで検証する。
## エラーがあれば Kwalify::ValidationError の配列が、なければ空の配列が返される。
document = YAML.load_file('document.yaml')
{{*errors = validator.validate(document)*}}
if !errors || errors.empty?
  puts "valid."
else
  errors.each do |error|
    puts "[#{error.path}] #{error.message}"
  end
end
