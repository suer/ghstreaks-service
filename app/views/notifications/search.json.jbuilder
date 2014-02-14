json.array!(@notifications) do |notification|
  json.extract! notification, :device_token, :hour, :utc_offset, :utc_hour, :last_notification_at
  json.user_name notification.user.name
end
