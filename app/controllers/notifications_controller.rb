class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
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
      params.require(:notification).permit(:user_id, :device_token, :hour, :minute, :last_notification_at)
    end
end
