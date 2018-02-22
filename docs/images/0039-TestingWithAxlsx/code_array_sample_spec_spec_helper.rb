# coding: utf-8
require 'axlsx'

RSpec.configure do |config|
  def excel
    @@excel ||= Axlsx::Package.new
  end

  def worksheet
    @@worksheet ||= excel.workbook.add_worksheet(name: 'Spec')
  end

  # テスト実行前にレポート作成の準備をする
  config.before(:suite) do
    worksheet.add_row(['検証項目', '○/×'])
  end

  # テスト実行後に成否を取得してレポートに記入する
  config.after(:each) do
    # テストの検証項目名を取得する
    description = self.example.full_description
    if self.example.metadata[:description].empty?
      description += RSpec::Matchers.generated_description
    end
    # テスト実行時に発生した例外を取得する
    exception = self.example.exception

    worksheet.add_row([description, exception ? 'x' : 'o'])
  end

  # テスト実行後に xlsx ファイルを保存する
  config.after(:suite) do
    excel.use_shared_strings = true # for Numbers
    excel.serialize('array_spec.xlsx')
  end
end
