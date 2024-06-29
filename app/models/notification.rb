class Notification < ApplicationRecord
  attr_accessor :phones
  validate :validate_phones

  enum status: { active: 1, deactive: 0 }

  belongs_to :customer

  scope :is_active, -> { where(status: active )}

  private
  def validate_phones
    return if phones.blank?
    phones.split(',').each do |phone|
      unless phone.to_i.strip =~ /\A0\d{9}\z/
        errors.add(:phones, "#{phone} is not a valid phone number")
      end
    end
  end

end
