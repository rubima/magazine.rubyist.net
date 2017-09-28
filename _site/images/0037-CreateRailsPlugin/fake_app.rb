# spec/fake_app.rb

# -*- coding: utf-8 -*-
require 'active_record'
require 'action_controller/railtie'
require 'action_view/helpers'
require 'need_label'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

# config
app = Class.new(Rails::Application)
app.config.secret_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.initialize!

# routes
app.routes.draw do
  resources :users
end

# models
class User < ActiveRecord::Base
  validates :name, :presence => true
end

# controllers
class ApplicationController < ActionController::Base; end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) {|t| t.string :name; t.integer :age}
  end
end
