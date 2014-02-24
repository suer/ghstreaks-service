class Notification < ActiveRecord::Base
  belongs_to :user

  validates :device_token, presence: true
  validates :hour, presence: true
  validates :utc_offset, presence: true

  before_save do
    self.utc_hour = (self.hour - self.utc_offset) % 24
  end

  def self.register(params, user)
    notification = Notification.where(device_token: params[:device_token]).first || Notification.new(device_token: params[:device_token])
    notification.hour = params[:hour]
    notification.utc_offset = params[:utc_offset]
    notification.user_id = user.id
    notification.save!
    notification
  end
end
