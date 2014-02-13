json.array!(@notifications) do |notification|
  json.extract! notification, :device_token, :hour, :minute, :utc_offset, :last_notification_at
  json.user_name notification.user.name
end
