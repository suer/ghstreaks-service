class StreaksController < ApplicationController
  def index
    render json: get_streaks(params[:user])
  end

  private
  def get_streaks(username)
    url = "https://github.com/users/#{username}/contributions_calendar_data"
    response = Faraday.get url
    first_streak, *rest_streaks = JSON.parse(response.body).reverse

    hash = {current_streaks: 0}

    hash[:current_streaks] += 1 if first_streak[1] > 0

    rest_streaks.each do |streak|
      break if streak[1] == 0
      hash[:current_streaks] += 1
    end

    hash
  end
end
