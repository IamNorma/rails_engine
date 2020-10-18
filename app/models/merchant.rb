class Merchant < ApplicationRecord
  validate :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
end
