class ConverstationRequest < ApplicationRecord

  belongs_to :expert, optional: true
  belongs_to :requester
  belongs_to :registered_number, optional: true

  before_create :allocate_registered_number_and_notify_experts
  after_create :schedule_subscription_sms

  def schedule_subscription_sms
    self.delay(run_at: 5.minutes.from_now).send_subscription_sms
  end
  
  def send_subscription_sms
    if self.registered_number.subscribed == false && self.status == "Booked"
      authorize = UrlShortener::Authorize.new 'binitkumar', 'R_32e0ad74a16043179a1ac1602e8bf737'
      @url_shortener_client = UrlShortener::Client.new authorize

      get_subscription_url = "http://#{Rails.application.secrets.domain_name}/charges/subscribe?conversation_request_id=#{self.id}"
      shorten = @url_shortener_client.shorten( get_subscription_url )
      SmsMessage.create(
        message: I18n.t("subscribe_conversation", subscription_url: shorten.shortUrl),
        sending_from: self.registered_number.number,
        sending_to: self.requester.contact_no
      )
      self.delay(run_at: 5.minutes.from_now).send_subscription_sms
    end
  end

  def allocate_registered_number_and_notify_experts
    RegisteredNumber.where("release_time < ?", Time.now).each do |num|
      unless num.subscribed
        num.status = 'Open'
        num.converstation_requests.each do |req|
          req.update_attribute(:status, 'Closed')
        end
        num.save
      end
    end

    open_registered_number = RegisteredNumber.where(status: 'Open').first
    open_registered_number.update_attribute(:status, 'Used')
    if open_registered_number
      self.registered_number = open_registered_number
      Expert.all.each do |expert|
        SmsMessage.create(
          expert: expert, 
          message: I18n.t("person_available_for_conversation"),
          sending_from: open_registered_number.number,
          sending_to: expert.contact_no
        )
      end
    else
      close_request(:no_phone_number_available)
    end    
  end

  def close_request(reason)
    if reason == :no_phone_number_available
      SmsMessage.create(
        requester: self.requester, 
        message: I18n.t("no_phone_no_available"),
        sending_from: MASTER_NO,
        sending_to: self.requester.contact_no
      )
    end

    self.status = 'Closed'
  end
end
