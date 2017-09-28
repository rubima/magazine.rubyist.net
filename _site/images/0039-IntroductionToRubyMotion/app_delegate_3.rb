class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    controller = UIViewController.new
    controller.view.backgroundColor = UIColor.whiteColor

    label = UILabel.new.tap do |l|
      l.text = 'foo'
      l.frame = [[10, 10], [100, 60]]
    end
    controller.view.addSubview(label)

    button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle('Say Hello!', forState:UIControlStateNormal)
      b.frame = [[110, 300], [100, 60]]
    end
    controller.view.addSubview(button)

    @window.rootViewController = controller
    @window.makeKeyAndVisible
    true
  end
end
