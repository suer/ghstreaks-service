require 'spec_helper'

describe Notification do
  describe 'find_or_create' do
    context 'if notifications not exists yet' do
      before do
        @params = {device_token: 'token', hour: 17, minute: 0}
        @user = User.create(name: 'name')
        Notification.delete_all
        Notification.create_and_add_to_user(@params, @user)
      end
      subject { Notification.where(device_token: 'token') }
      its(:size) { should eq 1 }
    end

    context 'if a notification exists already' do
      before do
        @params = {device_token: 'token', hour: 17, minute: 0}
        @user = User.create(name: 'name')
        Notification.delete_all
        @user.notifications << Notification.create(@params)
        Notification.create_and_add_to_user(@params, @user)
      end
      subject { @user.notifications }
      its(:size) { should eq 1 }
    end
  end
end
