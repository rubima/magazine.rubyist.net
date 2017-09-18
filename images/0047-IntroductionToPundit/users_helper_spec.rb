require 'spec_helper'

describe UsersHelper do
  describe ".user_show?" do
    context '管理者' do
      include_context "管理者"
      subject { user_show?(user) }
      it { should be_true }
    end
    
    context '権限保持者' do
      include_context "User"
      subject { user_show?(user) }
      it { should be_true }
    end
    
    context '権限非保持者' do
      include_context "Role"
      subject { user_show?(user) }
      it { should be_false }
    end
  end

  ...

end
