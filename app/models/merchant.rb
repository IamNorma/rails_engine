class Merchant < ApplicationRecord
  validates :name

  has_many :items
  has_many :invoices
end
