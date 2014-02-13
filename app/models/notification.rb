class Notification < ActiveRecord::Base
  belongs_to :user

  def self.create_and_add_to_user(params, user)
    params[:hour]   ||= 17
    params[:minute] ||= 0
    if user.notifications.exists?
      Notification.delete_all(user_id: user.id, device_token: params[:device_token])
    end
    notification = Notification.create(params)
    user.notifications << notification
    notification
  end
end
