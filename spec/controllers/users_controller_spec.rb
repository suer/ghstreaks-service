require 'spec_helper'

describe UsersController do
  context 'post create' do
    before do
      post :create, user: {name: 'name'}, format: 'json'
      @user = User.where(name: 'name').first
    end
    subject { @user }
    its(:name) { should eq 'name' }
  end
end
