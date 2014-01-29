require 'spec_helper'

describe UsersController do
  context 'post' do
    before do
      post :create, user: {name: 'name', device_token:'device_token'}, format: 'json'
      @user = User.where(name: 'name').first
    end
    subject { @user }
    its(:device_token) { should eq 'device_token' }
  end
end
