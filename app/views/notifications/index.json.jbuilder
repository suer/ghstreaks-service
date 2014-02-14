json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user_id, :device_token, :hour, :utc_offset, :utc_hour, :last_notification_at
  json.url notification_url(notification, format: :json)
end
