describe "The 'My View Controller' view" do
  tests MyViewController

  before do
    @label = view('foo')
  end

  it "change label's title" do
    tap('Say Hello!')
    @label.text.should == 'Hello'
  end
end
