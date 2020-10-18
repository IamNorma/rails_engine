class Item < ApplicationRecord
  validate :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
end
