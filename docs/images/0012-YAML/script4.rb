#!/usr/bin/env ruby

require 'kwalify'
require 'yaml'

## Kwalify::Validator のサブクラスを定義
class AnswersValidator < Kwalify::Validator

  ## スキーマ定義を読み込む
  @@schema = YAML.load_file('answers.schema.yaml')

  def initialize()
    super(@@schema)
  end

  ## Validator#validate() から呼び出されるフックメソッド
  def {{*validate_hook(value, rule, path, errors)*}}
    # ルールの名前が 'Answer' である場合だけ実行
    case {{*rule.name*}}
    when {{*'Answer'*}}
      # 解答が 'bad' であれば、理由の記入が必須である
      if value['answer'] == 'bad'
        if value['reason'] == nil || value['reason'].empty?
          msg = "reason is required when answer is 'bad'."
          {{*errors << Kwalify::ValidationError.new(msg, path)*}}
        end
      end
    end
  end

end


## YAML ドキュメントを読み込む
## (エラー行番号を表示するために、Kwalify::YamlParser を使う。)
input = ARGF.read()
parser = Kwalify::YamlParser.new(input)
document = parser.parse()

## バリデータを作成し、検証する
validator = AnswersValidator.new
errors = validator.validate(document)

## エラーがあれば行番号つきで表示する
if !errors || errors.empty?
  puts "Valid."
else
  parser.set_errors_linenum(errors)
  errors.sort.each do |error|
    puts " - line #{error.linenum}: [#{error.path}] #{error.message}"
  end
end
