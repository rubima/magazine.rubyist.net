  describe User, '#admin?' do
    before do
      @user = User.new(:name => 'jack')
      @user.role = Role.new(:role => role)
    end
    subject { @user }

    context 'admin' do
      let(:role) { :admin }
      it { should be_admin }
    end

    context 'not admin' do
      let(:role) { :normal }
      it { should_not be_admin }
    end
  end
