json.extract! sms_message, :id, :requester_id, :expert_id, :message, :created_at, :updated_at
json.url sms_message_url(sms_message, format: :json)
