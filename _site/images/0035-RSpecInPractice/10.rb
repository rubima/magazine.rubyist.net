  describe User, '#create!' do
    subject { User.creat! }
    it { should_not be_new_record }
    its(:profile) { should_not be_new_record }
    its('profile.name') { should eq 'AKAMATSU Yuki' }
  end
