class Notification < ApplicationRecord
  attr_accessor :phones

  validate :validate_phones

  enum status: { active: 1, deactive: 0 }

  belongs_to :customer

  scope :is_active, -> { where(status: active) }
end
