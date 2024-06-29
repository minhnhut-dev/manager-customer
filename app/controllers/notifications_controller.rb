class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.is_active
  end

  def send_sms
    byebug
    phone_numbers = params[:phones].split(',')
    content = params[:content]

    result = SendSmsServices.new(content, phone_numbers).execute!
    if result[:success]
      save_notifications(content, phone_numbers)
      flash[:notice] = result[:message]
      redirect_to notifications_path
    else
      flash[:alert] = result[:error]
      render :index
    end
  end

  private

  def save_notifications(message, phones)
    phones.each do |phone|
      customer = Customer.find_by(phone: phone)
      next if customer.blank?
      Notification.create!(content: message,  customer_id: customer.id, status: :active)
    end
  end

  def notifications_params
    params.permit(:name, :content, :customer_id)
  end
end
