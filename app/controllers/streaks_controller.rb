class StreaksController < ApplicationController
  def index
    render json: get_streaks(params[:user])
  end

  private
  def get_streaks(username)
    hash = {current_streaks: 0}
    url = "https://github.com/#{username}"
    html = Nokogiri::HTML(Faraday.get(url).body)
    nodes = html.css(".contrib-column > .contrib-number")
    return hash if nodes.empty?
    hash[:current_streaks] = nodes.last.text.split.first.to_i
    hash
  rescue
    {current_streaks: 0}
  end
end
