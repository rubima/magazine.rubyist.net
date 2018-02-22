# coding: utf-8
require 'capybara/cucumber'
require 'rspec/expectations'

require 'axlsx'
require 'mini_magick'

Capybara.default_driver = :selenium

World(RSpec::Matchers)

def excel
  @@excel ||= Axlsx::Package.new
end

def worksheet
  @@worksheet ||= excel.workbook.add_worksheet(name: 'Features') do |sheet|
    sheet.add_row(['検証項目', '○/×'])
  end
end

def serial_number
  @@serial_number ||= 0
  @@serial_number += 1
end

# スクリーンショットを貼り付ける
After do |scenario|
  spec_number = serial_number

  image_src = 'screenshot_%i.png' % spec_number
  # スクリーンショットを取得する(driver 非互換)
  page.driver.browser.save_screenshot(image_src)

  # 画像のサイズを取得し設定する
  image_data = MiniMagick::Image.open(image_src)
  excel.workbook.add_worksheet(name: 'Screenshot %s' % spec_number) do |sheet|
    sheet.add_image(image_src: image_src) do |image|
      image.width = image_data[:width]
      image.height = image_data[:height]
    end
  end
end

# テスト実行後に成否を取得してレポートに記入する
After do |scenario|
  # テストの検証項目名を取得する
  description = scenario.title
  # テストの成否を取得する
  failed = scenario.failed?

  worksheet.add_row([description, failed ? '×' : '○'])
end

# テスト実行後に xlsx ファイルを保存する
at_exit do
  excel.use_shared_strings = true # for Numbers
  excel.serialize('rubima_features.xlsx')
end
