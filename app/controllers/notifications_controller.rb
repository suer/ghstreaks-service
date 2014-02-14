class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def search
    @notifications = if params[:hour]
      Notification.includes(:user).where(hour: params[:hour])
    else
      Notification.includes(:user).all
    end
  end

  def show
  end

  def create
    user = User.find_or_create(name: params[:notification][:name])
    @notification = Notification.create_and_add_to_user(notification_params, user)

    if @notification
      ZeroPush.register(@notification.device_token)
      render action: 'show', status: :created, location: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  def update
    if @notification.update(notification_params)
      head :no_content
    else
      render json: @notification.errors, status: :unprocessable_entity
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
end
