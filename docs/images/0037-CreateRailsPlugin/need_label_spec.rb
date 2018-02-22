# spec/requests/need_label_spec.rb

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "output need-label class" do
  describe "instance variable type without options" do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for @user do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

##(略)##

end

