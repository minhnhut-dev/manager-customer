module ValidateCustomers
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, uniqueness: true
    validate :custom_validation_method
  end

  def custom_validation_method
    errors.add(:base, 'Custom validation error message') unless some_condition_is_met?
  end

  private

  def some_condition_is_met?
    true
  end
end
