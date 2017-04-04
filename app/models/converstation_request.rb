class ConverstationRequest < ApplicationRecord

  belongs_to :expert, optional: true
  belongs_to :requester
  belongs_to :registered_number, optional: true

  before_create :allocate_registered_number_and_notify_experts

  def allocate_registered_number_and_notify_experts
    open_registered_nubmer = RegisteredNumber.where(status: 'Open').first

    if open_registered_nubmer
      self.registered_number = open_registered_nubmer
      Expert.all.each do |expert|
        SmsMessage.create(
          expert: expert, 
          message: 'Person available for conversation. Respond to this number to join this conversation',
          sending_from: open_registered_nubmer.number,
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
