class ConverstationRequest < ApplicationRecord

  belongs_to :expert, optional: true
  belongs_to :requester
  belongs_to :registered_number, optional: true

  before_create :allocate_registered_number_and_notify_experts

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
          message: 'Person available for conversation. Respond to this number to join this conversation',
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
        message: 'Unable to serve request as no open phone numbers available right now.',
        sending_from: MASTER_NO,
        sending_to: self.requester.contact_no
      )
    end

    self.status = 'Closed'
  end
end
