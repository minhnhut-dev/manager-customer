module ApplicationHelper
  def format_date_vietnam(date)
    date.strftime('%d/%m/%Y')
  end

  def current_url
    request.original_url
  end

  def active_module
    controller_name
  end
end
