# jp_yen_spec.rb
require 'rspec'
require './jp_yen'

describe "JpYen" do
  it "Checks that a yen is displayed" do
    10.yen.should == "10yen"
  end
end

