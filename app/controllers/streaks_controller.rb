class StreaksController < ApplicationController
  def index
    render json: get_streaks(params[:user])
  end

  private
  def get_streaks(username)
    hash = {current_streaks: 0}
    url = "https://github.com/#{username}"
    html = Nokogiri::HTML(Faraday.get(url).body)
    node = html.css(".contrib-streak-current > .num")
    return hash if node.empty?
    hash[:current_streaks] = node.text.split.first.to_i
    hash
  rescue
    {current_streaks: 0}
  end
end
