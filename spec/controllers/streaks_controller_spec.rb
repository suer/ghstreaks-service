require 'spec_helper'

describe StreaksController do

  describe "GET 'index'" do
    before do
      res = double
      res.stub(:body) { '<div class="contrib-column"><span class="contrib-number">2 days</span></div>' }
      Faraday.stub(:get) { res }
    end
    it "last streak is not 0" do
      get 'index', user: 'test'
      response.body.should eq '{"current_streaks":2}'
    end
  end

end
