# coding: utf-8

Feature: るびまを閲覧できる
  Scenario: るびまのトップページを閲覧できる
    When  webサイト "http://jp.rubyist.net/magazine/" にアクセスする
    Then  ページタイトルが "るびま" であること
