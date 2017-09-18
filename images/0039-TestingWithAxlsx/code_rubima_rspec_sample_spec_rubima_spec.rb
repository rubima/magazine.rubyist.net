# coding: utf-8
require_relative './spec_helper'

describe 'るびま' do
  context 'トップページにアクセスした場合' do
    before do
      visit 'http://jp.rubyist.net/magazine/'
    end

    it 'タイトルに "るびま" と表示されていること' do
      page.should have_css('h1', text: 'るびま')
    end
  end
end
