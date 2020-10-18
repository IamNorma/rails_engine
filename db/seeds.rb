# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

Transaction.destroy_all
InvoiceItem.destroy_all
Invoice.destroy_all
Item.destroy_all
Merchant.destroy_all
Customer.destroy_all

CSV.foreach('lib/seeds/customers.csv', headers: true, header_converters: :symbol) do |row|
  Customer.create!(row.to_h)
end
puts "There are now #{Customer.count} rows in the customers table"

CSV.foreach('lib/seeds/merchants.csv', headers: true, header_converters: :symbol) do |row|
  Merchant.create!(row.to_h)
end
puts "There are now #{Merchant.count} rows in the merchants table"

CSV.foreach('lib/seeds/items.csv', headers: true, header_converters: :symbol) do |row|
  Item.create!({
    id: row[:id],
    name: row[:name],
    description: row[:description],
    unit_price: row[:unit_price].to_f / 100,
    merchant_id: row[:merchant_id],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
    }
  )
end
puts "There are now #{Item.count} rows in the items table"

CSV.foreach('lib/seeds/invoices.csv', headers: true, header_converters: :symbol) do |row|
  Invoice.create!(row.to_h)
end
puts "There are now #{Invoice.count} rows in the invoices table"

CSV.foreach('lib/seeds/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
  InvoiceItem.create!({
    id: row[:id],
    item_id: row[:item_id],
    invoice_id: row[:invoice_id],
    quantity: row[:quantity],
    unit_price: row[:unit_price].to_f / 100,
    created_at: row[:created_at],
    updated_at: row[:updated_at]
    }
  )
end
puts "There are now #{InvoiceItem.count} rows in the invoice items table"

CSV.foreach('lib/seeds/transactions.csv', headers: true, header_converters: :symbol) do |row|
  Transaction.create!(row.to_h)
end
puts "There are now #{Transaction.count} rows in the transactions table"

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
