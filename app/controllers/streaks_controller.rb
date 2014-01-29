class StreaksController < ApplicationController
  def index
    render json: get_streaks(params[:user])
  end

  private
  def get_streaks(username)
    url = "https://github.com/users/#{username}/contributions_calendar_data"
    response = Faraday.get url
    streaks = JSON.parse(response.body)

    streaks.reverse.each_with_index do |streak, i|
      return {current_streaks: i} if streak[1] == 0
    end
    {current_streaks: streaks.size}
  end
end
