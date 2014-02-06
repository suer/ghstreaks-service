require 'spec_helper'

describe Notification do
  describe 'find_or_create' do
    context 'not exists yet' do
      before do
        @params = {device_token: 'token', hour: 17, minute: 0}
        @user = User.create!(name: 'name')
        Notification.delete_all
        Notification.find_or_create(@params, @user)
      end
      subject { Notification.where(device_token: 'token') }
      its(:size) { should eq 1 }
    end

    context 'exists already' do
      before do
        @params = {device_token: 'token', hour: 17, minute: 0}
        @user = User.create!(name: 'name')
        Notification.delete_all
        Notification.create!(@params)
        Notification.find_or_create(@params, @user)
      end
      subject { Notification.where(device_token: 'token') }
      its(:size) { should eq 1 }
    end
  end
end
