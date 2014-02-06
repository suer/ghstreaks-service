require 'spec_helper'

describe User do
  describe 'find_or_create' do
    context 'not exists yet' do
      before do
        @params = {name: 'name'}
        User.delete_all
        User.create!(@params)
        User.find_or_create(@params)
      end
      subject { User.where(@params) }
      its(:size) { should eq 1 }
    end

    context 'exists already' do
      before do
        @params = {name: :name}
        User.delete_all
        User.find_or_create(@params)
      end
      subject { User.where(@params) }
      its(:size) { should eq 1 }
    end
  end
end
