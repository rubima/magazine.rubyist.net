# coding: utf-8

When /^webサイト "(.*?)" にアクセスする$/ do |url|
  visit url
end

Then /^ページタイトルが "(.*?)" であること$/ do |title|
  page.should have_css('h1', text: title)
end
