class TwilioSms < ApplicationRecord

  def self.send_message receiver, sender, message

    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = ENV['TWILIO_PHONE_NO']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => sender,
      :to => receiver,
      :body => message
    )
  end
end
