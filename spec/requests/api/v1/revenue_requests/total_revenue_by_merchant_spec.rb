require 'rails_helper'

describe "Revenue API" do
  it 'can get total revenue for a single merchant' do
    customer = create(:customer)

    merchant1 = create(:merchant, name: "Apple")
    merchant2 = create(:merchant, name: "Target")
    merchant3 = create(:merchant, name: "Vallarta's")

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    item3 = create(:item, merchant: merchant2)
    item4 = create(:item, merchant: merchant3)
    item5 = create(:item, merchant: merchant3)

    invoice1 = create(:invoice, customer: customer, merchant: merchant1, created_at: '2012-03-25')
    invoice2 = create(:invoice, customer: customer, merchant: merchant1, created_at: '2012-03-25')
    invoice3 = create(:invoice, customer: customer, merchant: merchant2, created_at: '2012-03-26')
    invoice4 = create(:invoice, customer: customer, merchant: merchant3, created_at: '2012-03-27')
    invoice5 = create(:invoice, customer: customer, merchant: merchant3, created_at: '2012-03-28')
    invoice6 = create(:invoice, customer: customer, merchant: merchant3, created_at: '2012-03-29')

    create(:invoice_item, quantity: 2, unit_price: 2, item: item1, invoice: invoice1)
    create(:invoice_item, quantity: 4, unit_price: 2, item: item2, invoice: invoice1)
    create(:invoice_item, quantity: 1, unit_price: 2, item: item1, invoice: invoice2)
    create(:invoice_item, quantity: 1, unit_price: 2, item: item2, invoice: invoice2)
    create(:invoice_item, quantity: 3, unit_price: 2, item: item3, invoice: invoice3)
    create(:invoice_item, quantity: 2, unit_price: 2, item: item4, invoice: invoice4)
    create(:invoice_item, quantity: 1, unit_price: 2, item: item5, invoice: invoice5)
    create(:invoice_item, quantity: 3, unit_price: 2, item: item4, invoice: invoice6)

    create(:transaction, invoice: invoice1)
    create(:transaction, invoice: invoice2)
    create(:transaction, invoice: invoice3)
    create(:transaction, invoice: invoice4)
    create(:transaction, invoice: invoice5)
    create(:transaction, invoice: invoice6)

    get '/api/v1/merchants/1/revenue'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:revenue].to_f.round(2)).to eq(34.00)
  end
end
