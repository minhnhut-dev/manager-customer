require 'rubygems'
require 'twilio-ruby'

class SendSmsServices
  def initialize(message, phones = [])
    @message = message
    @phones = phones
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
  end

  def execute!
    send_sms
  end

  def send_sms
    validate_phones!

    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    begin
      message = @client.messages.create(
        to: '+84911079197',
        from: '+1 415 233 9307',
        body: @message
      )

      unless message.status == 'queued' || message.status == 'sent'
        return { success: false, error: 'Failed to send SMS.' }
      end

      save_notifications
      { success: true, message: 'SMS sent successfully.' }
    rescue Twilio::REST::RestError => e
      { success: false, error: e.message }
    end
  end

  private

  def validate_phones!
    return if @phones.blank?

                @phones.each do |phone|
      next if phone.strip =~ /\A0\d{9}\z/

      # raise StandardError.new("#{phone} is not a valid phone number")
      return { success: false, error: "#{phone} is not a valid phone number" }
    end
  end

  def save_notifications
    @phones.each do |phone|
      customer = Customer.find_by(phone: phone)
      next if customer.blank?

      Notification.create!(content: @message, customer_id: customer.id, status: :active)
    end
  end
end
