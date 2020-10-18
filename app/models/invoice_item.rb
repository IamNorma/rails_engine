class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice
end
