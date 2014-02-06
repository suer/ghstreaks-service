require 'spec_helper'
describe NotificationsController do

  before do
    ZeroPush.stub(:register) { nil }
  end

  context 'search' do
    before do
      Notification.delete_all
      user = User.create!(name: 'name')
      Notification.create!(user_id: user.id, device_token: 'device_token', hour: 10, minute: 30)
      get :search, hour: 10, minute: 30, format: :json
      @json = JSON.parse(response.body)
    end
    subject { @json.first }
    its(['device_token']) { should eq 'device_token' }
    its(['user_name']) { should eq 'name' }
  end

  context 'post create' do
    context 'registered user' do
      before do
        @user = User.create!(name: 'name')
        post :create, notification: {name: 'name', device_token: 'device_token', hour: 18, minute: 30}, format: 'json'
        @notification = Notification.where(user_id: @user.id, device_token: 'device_token').first
      end
      subject { @notification }
      its(:device_token) { should eq 'device_token' }
      its(:hour) { should eq 18 }
      its(:minute) { should eq 30 }
    end

    context 'dupricated notifications' do
      before do
        @user = User.create!(name: 'name')
        post :create, notification: {name: 'name', device_token: 'device_token', hour: 18, minute: 30}, format: 'json'
        post :create, notification: {name: 'name', device_token: 'device_token', hour: 18, minute: 30}, format: 'json'
        @notifications = Notification.where(user_id: @user.id, device_token: 'device_token', hour: 18, minute: 30)
      end
      subject { @notifications }
      its(:size) { should eq 1 }
    end

    context 'unregistered user' do
      before do
        User.delete_all(name: 'name')
        post :create, notification: {name: 'name', device_token: 'device_token', hour: 18, minute: 30}, format: 'json'
        @json = JSON.parse(response.body)
      end
      subject { User.find('name') }
      its(:name) { should eq 'name' }
    end
  end
end
