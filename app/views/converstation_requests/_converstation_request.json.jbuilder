json.extract! converstation_request, :id, :requester_id, :exptert_id, :created_at, :updated_at
json.url converstation_request_url(converstation_request, format: :json)
