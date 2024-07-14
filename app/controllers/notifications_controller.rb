class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.is_active
  end

  def send_sms
    phone_numbers = params[:phones].split(',')
    content = params[:content]
    result = SendSmsServices.new(content, phone_numbers).execute!
    if result[:success]
      flash[:notice] = result[:message]
      redirect_to notifications_path
    else
      flash[:notice] = result[:error]
      redirect_to notifications_path
    end
  end
end
