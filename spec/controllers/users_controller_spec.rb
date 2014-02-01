require 'spec_helper'

describe UsersController do
  describe 'get' do
    context 'unregistered user' do
      before do
        User.delete_all(name: 'name')
        get :show, id: 'name', format: 'json'
        @json = JSON.parse(response.body)
      end
      subject { @json }
      its(["error"]) { should eq 'User name not found' }
    end

    context 'registered user' do
      before do
        User.create!(name: 'name')
        get :show, id: 'name', format: 'json'
        @json = JSON.parse(response.body)
      end
      subject { @json }
      its(["name"]) { should eq 'name' }
    end

  end
  context 'post create' do
    before do
      post :create, user: {name: 'name'}, format: 'json'
      @user = User.where(name: 'name').first
    end
    subject { @user }
    its(:name) { should eq 'name' }
  end
end
