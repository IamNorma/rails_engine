require 'rails_helper'

describe "Merchants API" do
  it 'can get merchants who have sold the most items' do
    customer = create(:customer)

    merchant1 = create(:merchant, name: "Apple")
    merchant2 = create(:merchant, name: "Target")
    merchant3 = create(:merchant, name: "Vallarta's")

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    item3 = create(:item, merchant: merchant2)
    item4 = create(:item, merchant: merchant3)
    item5 = create(:item, merchant: merchant3)

    invoice1 = create(:invoice, customer: customer, merchant: merchant1, status: "shipped")
    invoice2 = create(:invoice, customer: customer, merchant: merchant1, status: "not shipped")
    invoice3 = create(:invoice, customer: customer, merchant: merchant2, status: "shipped")
    invoice4 = create(:invoice, customer: customer, merchant: merchant3, status: "shipped")
    invoice5 = create(:invoice, customer: customer, merchant: merchant3, status: "shipped")
    invoice6 = create(:invoice, customer: customer, merchant: merchant3, status: "shipped")

    create(:invoice_item, quantity: 2, unit_price: 2, item: item1, invoice: invoice1)
    create(:invoice_item, quantity: 4, unit_price: 2, item: item2, invoice: invoice1)
    create(:invoice_item, quantity: 1, unit_price: 2, item: item1, invoice: invoice2)
    create(:invoice_item, quantity: 1, unit_price: 2, item: item2, invoice: invoice2)
    create(:invoice_item, quantity: 3, unit_price: 2, item: item3, invoice: invoice3)
    create(:invoice_item, quantity: 2, unit_price: 2, item: item4, invoice: invoice4)
    create(:invoice_item, quantity: 1, unit_price: 2, item: item5, invoice: invoice5)
    create(:invoice_item, quantity: 3, unit_price: 2, item: item4, invoice: invoice6)

    create(:transaction, invoice: invoice1,  result: 'failed')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'success')
    create(:transaction, invoice: invoice4, result: 'success')
    create(:transaction, invoice: invoice5, result: 'success')
    create(:transaction, invoice: invoice6, result: 'success')

    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(2)
    expect(json[:data][0][:attributes][:name]).to eq("Target")
    expect(json[:data][1][:attributes][:name]).to eq("Vallata's")

    json[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:attributes)
      expect(merchant).to be_a(Hash)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant).to have_key(:relationships)
      expect(merchant).to be_a(Hash)
      expect(merchant[:relationships]).to have_key(:items)
      expect(merchant[:relationships]).to be_a(Hash)
      expect(merchant[:relationships][:items]).to have_key(:data)
      expect(merchant[:relationships][:items]).to be_a(Hash)

      items = merchant[:relationships][:items][:data]
      expect(items).to be_an(Array)
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item).to have_key(:type)
        expect(item[:type]).to eq("item")
      end
    end
  end
end
