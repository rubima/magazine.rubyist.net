require 'spec_helper'
 
describe UserPolicy do
  subject { UserPolicy }

  ...

  permissions :update? do
    context '管理者' do
      include_context "管理者"
      it { should permit(user, User.new) }
    end
 
    context '権限保持者' do
      include_context "User"
      it { should permit(user, User.new) }
    end
    
    context '権限非保持者' do
      include_context "Role"
      it { should_not permit(user, User.new) }
    end
  end

  ...
