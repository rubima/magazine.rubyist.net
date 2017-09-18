require 'mini_magick'

# ...

RSpec.configure do |config|

  # ...

  def serial_number
    @@serial_number ||= 0
    @@serial_number += 1
  end

  # テスト実行後にスクリーンショットを取得して xlsx ファイルに貼り付ける
  config.after(:each) do
    spec_number = serial_number

    image_src = './screenshot_%i.png' % spec_number
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
end
