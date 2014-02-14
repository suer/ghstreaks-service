require 'spec_helper'

describe Notification do
  describe 'find_or_create' do
    context 'if notifications not exists yet' do
      before do
        @params = {device_token: 'token', hour: 17, utc_offset: 9}
        @user = User.create(name: 'name')
        Notification.delete_all
        Notification.create_and_add_to_user(@params, @user)
      end
      subject { Notification.where(device_token: 'token') }
      its(:size) { should eq 1 }
    end

    context 'if a notification exists already' do
      before do
        @params = {device_token: 'token', hour: 17, utc_offset: 9}
        @user = User.create(name: 'name')
        Notification.delete_all
        @user.notifications << Notification.create(@params)
        Notification.create_and_add_to_user(@params, @user)
      end
      subject { @user.notifications }
      its(:size) { should eq 1 }
    end

    describe 'utc_hour calculated automatically' do
      context 'hour = 17 and utc_offset =  9' do
        subject { Notification.create(device_token: 'device_token', hour: 17, utc_offset: 9) }
        its(:utc_hour) { should eq 8 }
      end

      context 'hour = 8 and utc_offset =  9' do
        subject { Notification.create(device_token: 'device_token', hour: 8, utc_offset: 9) }
        its(:utc_hour) { should eq 23 }
      end

      context 'hour = 9 and utc_offset =  9' do
        subject { Notification.create(device_token: 'device_token', hour: 9, utc_offset: 9) }
        its(:utc_hour) { should eq 0 }
      end

      context 'hour = 17 and utc_offset =  -9' do
        subject { Notification.create(device_token: 'device_token', hour: 17, utc_offset: -9) }
        its(:utc_hour) { should eq 2 }
      end
    end
  end
end
