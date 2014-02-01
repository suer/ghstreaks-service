json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user_id, :device_token, :hour, :minute, :last_notification_at
  json.url notification_url(notification, format: :json)
end
