class Customer < ApplicationRecord
  include ValidateCustomers
  include QueryCustomers
end
