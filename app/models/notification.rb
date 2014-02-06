class Notification < ActiveRecord::Base
  belongs_to :user

  def self.find_or_create(params, user)
    params[:hour]   ||= 17
    params[:minute] ||= 0
    notification = Notification.where(params).first || Notification.create(params)
    user.notifications << notification
    notification
  end
end
