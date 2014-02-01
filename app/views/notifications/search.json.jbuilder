json.array!(@notifications) do |notification|
  json.extract! notification, :device_token, :hour, :minute, :last_notification_at
  json.user_name notification.user.name
end
