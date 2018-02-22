  describe User, '#create!' do
    before { @user=User.create! }
    subject { @user }
    it { should_not be_new_record }

    descirbe Profile do
      subject { @user.profile }
      it { should_not be_new_record }
      its(:name) { should eq 'AKAMATSU Yuki' }
    end
  end
