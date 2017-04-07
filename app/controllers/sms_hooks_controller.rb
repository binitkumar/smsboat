class SmsHooksController < ApplicationController

  def receive_conversation_request
    requester_contact_no = params[:From]
    message = params[:Body]

    requester = Requester.where(contact_no: requester_contact_no).first_or_create
    
    ConverstationRequest.create(requester: requester, message: message)

    render xml: "<message>success</message>"
  end

  def connect_conversation
    connecting_no = params[:To]
    message = params[:Body]
    
    connecting_line = RegisteredNumber.find_by_number(connecting_no)
    connecting_line.update_column(:release_time, Time.now + 24.hours )
    connecting_line.save!

    expert = nil

    received_from = params[:From]
    requester = Requester.find_by_contact_no received_from
    expert = Expert.find_by_contact_no received_from if requester.nil?

    request = connecting_line.converstation_requests.where(status: 'Open').first
    booked_request = connecting_line.converstation_requests.where(status: 'Booked', expert: expert).first
    requester_booked_request = connecting_line.converstation_requests.where(status: 'Booked', requester: requester ).first
    if expert
      if request
        request.status = 'Booked'
        request.expert = expert
        request.save

        SmsMessage.create(
          expert: expert,
          message: message,
          sending_from: request.registered_number.number,
          sending_to: request.requester.contact_no    
        )
      elsif booked_request
        SmsMessage.create(
          requester: booked_request.requester,
          expert: expert,
          message: message,
          sending_from: booked_request.registered_number.number,
          sending_to: booked_request.requester.contact_no    
        )
      else
        SmsMessage.create(
          expert: expert,
          message: "Converstation already taken",
          sending_from: connecting_no,
          sending_to: expert.contact_no
        )
      end
    elsif requester
      if requester_booked_request
        if uses_limit_available(requester, connecting_no)
          SmsMessage.create(
            expert: requester_booked_request.expert,
            requester: requester,
            message: message,
            sending_from: connecting_no,
            sending_to: requester_booked_request.expert.contact_no
          )
        end
      else
        SmsMessage.create(
          requester: requester,
          message: 'No ongoing conversation found for you',
          sending_from: connecting_no,
          sending_to: requester.contact_no
        )
      end 
    end
      
    render xml: "<message>success</message>"
  end

  def uses_limit_available requester, connecting_no
    uses_limit = Rails.application.secrets.free_sms_count + requester.total_credit_points

    if uses_limit < requester.sms_messages.count
      get_credit_url = "http://#{Rails.application.secrets.domain_name}/charges/preview?requester_id=#{requester.id}"
      shorten = @url_shortener_client.shorten( get_credit_url )
      SmsMessage.create(
        message: "Uses limit exhausted. Please add credit to your account using this link #{shorten.shortUrl}",
        sending_from: connecting_no,
        sending_to: requester.contact_no
      )
      false 
    else
      true
    end    
  end
end
