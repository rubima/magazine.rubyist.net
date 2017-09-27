    label = UILabel.new.tap do |l|
      l.text = 'foo'
      l.frame = [[110, 100], [100, 20]]
    end
    controller.view.addSubview(label)
