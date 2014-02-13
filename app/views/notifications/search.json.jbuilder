json.array!(@notifications) do |notification|
  json.extract! notification, :device_token, :hour, :minute, :timezone, :last_notification_at
  json.user_name notification.user.name
end
