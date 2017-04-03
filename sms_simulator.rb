message = nil
puts "Enter host url"
host_url = gets.chomp

until message == 'exit' do
  begin
    puts "Message:"
    message = gets.chomp

    url = "http://#{host_url}/sms_hooks?ToCountry=US&ToState=VA&SmsMessageSid=SM1a242410a5b91532025fa1b68b01513b&NumMedia=0&ToCity=NOKESVILLE&FromZip=&SmsSid=SM1a242410a5b91532025fa1b68b01513b&FromState=ON&SmsStatus=received&FromCity=TORONTO&Body=#{message}&FromCountry=CA&To=%2B17035963227&MessagingServiceSid=MG8d28fe1f0b48b1e30e08fa0b666d8f5e&ToZip=20181&NumSegments=1&MessageSid=SM1a242410a5b91532025fa1b68b01513b&AccountSid=AC3939671c88887e60aebea8fa6c5828a0&From=%2B16478623287&ApiVersion=2010-04-01"

    puts url

    resp = RestClient.get(url)
    puts resp.body.inspect
   
  rescue => exp
    puts exp.message
  end 
end
