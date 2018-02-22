describe "Application 'Hello'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end

  describe "rootViewController" do
    before do
      @controller = @app.keyWindow.rootViewController
    end

    it "is an instance of MyViewController" do 
      @controller.class.should == MyViewController
    end
  end

end
