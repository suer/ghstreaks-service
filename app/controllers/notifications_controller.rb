class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def search
    @notifications = if params[:hour]
      Notification.includes(:user).where(utc_hour: params[:hour])
    else
      Notification.includes(:user).all
    end
  end

  def show
  end

  def create
    unless params[:notification] and not params[:notification][:name].blank?
      render json: {error: 'parameter notification[name] missing', params: params}, status: :unprocessable_entity
      return
    end

    unless github_user_exists(params[:notification][:name])
      render json: {error: "GitHub user '#{params[:notification][:name]}' does not exist", params: params}, status: :unprocessable_entity
      return
    end

    user = User.find_or_create(name: params[:notification][:name])
    begin
      @notification = Notification.register(notification_params, user)
    rescue ActiveRecord::RecordInvalid
      render json: {error: 'cannot save notification', params: params}, status: :unprocessable_entity
      return
    end

    if @notification
      ZeroPush.register(@notification.device_token)
      render action: 'show', status: :created, location: @notification
    else
      render json: {error: 'cannot save notification', params: notification_params}, status: :unprocessable_entity
    end
  end

  def update
    if @notification.update(notification_params)
      head :no_content
    else
      render json: {error: 'cannot save notification', params: notification_params}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:user_id, :device_token, :hour, :utc_offset, :last_notification_at)
    end

    def github_user_exists(username)
      response = Faraday.get("https://api.github.com/users/#{username}")
      response.status < 300
    end
end
