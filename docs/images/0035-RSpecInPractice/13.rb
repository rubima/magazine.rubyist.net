  describe User, '#admin?' do
    before do
      @user = User.new(:name => 'jack')
    end
    subject { @user }

    context 'admin' do
      before do
        @user.role = Role.new(:role => :admin)
      end

      it { should be_admin }
    end

    context 'not admin' do
      before do
        @user.role = Role.new(:role => :normal)
      end

      it { should_not be_admin }
    end
  end
