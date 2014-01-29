require 'spec_helper'

describe StreaksController do

  describe "GET 'index'" do
    before do
      res = mock
      res.stub(:body) { '[["2014/01/01", 0], ["2014/01/01", 1]]' }
      Faraday.stub(:get) { res }
    end
    it "returns http success" do
      get 'index', user: 'test'
      response.body.should eq '{"current_streaks":1}'
    end
  end

end
