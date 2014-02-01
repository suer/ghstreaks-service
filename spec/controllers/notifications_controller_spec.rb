require 'spec_helper'
describe NotificationsController do
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

    context 'unregistered user' do
      before do
        User.delete_all(name: 'name')
        post :create, notification: {name: 'name', device_token: 'device_token', hour: 18, minute: 30}, format: 'json'
        @json = JSON.parse(response.body)
      end
      subject { @json }
      its(["error"]) { should eq 'User name not found' }
    end
  end
end
