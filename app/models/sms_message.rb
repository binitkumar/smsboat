class SmsMessage < ApplicationRecord
  belongs_to :expert, optional: true
  belongs_to :requester, optional: true
end
