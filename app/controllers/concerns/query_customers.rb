module QueryCustomers
  extend ActiveSupport::Concern
  included do
    scope :is_customer_active, -> { where(status: :active) }
    enum status: { active: 1, deactive: 0 }
  end

  class_methods do
    def find_customer_by_ids(ids = [])
      where(id: ids).is_customer_active
    end
  end
end