require 'rails_helper'

describe "Merchants Items" do
  it 'sends a list of items associated with a merchant' do
    merchant1 = create(:merchant, id: 1)
    merchant2 = create(:merchant, id: 2)

    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(3)

    json[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)

      expect(item).to have_key(:relationships)
      expect(item[:relationships]).to be_a(Hash)
      expect(item[:relationships]).to have_key(:merchant)
      expect(item[:relationships][:merchant]).to be_a(Hash)
      expect(item[:relationships][:merchant]).to have_key(:data)
      expect(item[:relationships][:merchant][:data]).to be_a(Hash)

      merchant = item[:relationships][:merchant][:data]
      expect(merchant).to be_a(Hash)
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")
    end
  end
end
