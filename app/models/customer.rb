class Customer < ApplicationRecord
  validates :first_name, :last_name

  has_many :invoices
end
