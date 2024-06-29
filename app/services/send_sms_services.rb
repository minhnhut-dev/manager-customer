require 'rubygems'
require 'twilio-ruby'

class SendSmsServices

  def initialize(message, phones = [])
    @message = message
    @phones = phones
  end

  def execute!
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]
    byebug
    validate_phones

    return { success: false, error: 'No phone number provided.' } if @phones.blank?

    @client = Twilio::REST::Client.new(account_sid, auth_token)

    begin
      message = @client.messages.create(
        to: '+84911079197',
        from: '+1 415 233 9307',
        body: @message
      )
      if message.status == 'queued' || message.status == 'sent'
        return { success: true, message: 'SMS sent successfully.' }
      else
        return { success: false, error: 'Failed to send SMS.' }
      end
    rescue Twilio::REST::RestError => e
      return { success: false, error: e.message }
    end
  end

  private
  def validate_phones
    return if @phones.blank?
     @phones.each do |phone|
        unless phone.strip =~ /\A0\d{9}\z/
          raise StandardError.new("#{phone} is not a valid phone number")
        end
      end
  end
end