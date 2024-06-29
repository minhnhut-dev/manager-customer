require 'roo'

class ImportServices
  def initialize(file)
    @file = file
    validate_excel_format
  end

  def import_customers
    spreadsheet = Roo::Excelx.new(@file.path)
    header = spreadsheet.row(1)
    errors = []
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      error_message = create_customer(row)
      errors << error_message unless error_message.nil?
    end
    errors.join(', ') unless errors.empty?
  end

  private

  def validate_excel_format
    unless @file.content_type.in?(%w(application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.ms-excel))
      raise 'Invalid file format. Please upload an Excel file.'
    end
  end

  def create_customer(row)
    customer = Customer.create(row)
    unless customer.persisted?
      return customer.errors.full_messages.to_sentence
    end
    nil  # Return nil if no errors
  end
end