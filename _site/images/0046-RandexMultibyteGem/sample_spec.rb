require "spec_helper"
require "randexp"

describe "Game Title" do
  context "when input valiid value" do
     before :all do
       @input_value = /\w{15}/.gen #randexp でランダムに生成
       edit_game_info(:game_title => @input_value)
     end

     it "is shown in game info" do
       expect(game_info[:title]).to eq(@input_value)
     end
  end
end

