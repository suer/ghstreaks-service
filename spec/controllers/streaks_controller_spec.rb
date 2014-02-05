require 'spec_helper'

describe StreaksController do

  describe "GET 'index'" do
    before do
      res = mock
      res.stub(:body) { '[["2014/01/01", 0], ["2014/01/02", 1], ["2014/01/03", 1]]' }
      Faraday.stub(:get) { res }
    end
    it "last streak is not 0" do
      get 'index', user: 'test'
      response.body.should eq '{"current_streaks":2}'
    end
  end

  describe "GET 'index'" do
    before do
      res = mock
      res.stub(:body) { '[["2014/01/01", 0], ["2014/01/02", 1], ["2014/01/03", 0]]' }
      Faraday.stub(:get) { res }
    end
    it "last streak is 0" do
      get 'index', user: 'test'
      response.body.should eq '{"current_streaks":1}'
    end
  end
end
