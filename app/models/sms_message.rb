class SmsMessage < ApplicationRecord
  belongs_to :expert, optional: true
  belongs_to :requester, optional: true

  before_create :send_message

  def send_message
    TwilioSms.send_message(self.sending_to, self.sending_from, message)
  end
end
