class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  def self.most_revenue(limit)
    quantity = limit.to_i
    joins(invoices: [:invoice_items, :transactions])
    .select('merchants.id, merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.most_items(limit)
    quantity = limit.to_i
    joins(invoices: [:invoice_items, :transactions])
    .select('merchants.id, merchants.name, SUM(invoice_items.quantity) AS sold')
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group(:id)
    .order('sold DESC')
    .limit(quantity)
  end
end
