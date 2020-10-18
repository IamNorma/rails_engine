class Merchant < ApplicationRecord
  validates :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
end
