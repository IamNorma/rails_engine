require 'rails_helper'

describe "Merchants API" do
  it 'sends a list of merchants' do
    merchant1 = create(:merchant, id: 1)
    merchant2 = create(:merchant, id: 2)
    merchant3 = create(:merchant, id: 3)

    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant2.id)
    create(:item, merchant_id: merchant3.id)
    create(:item, merchant_id: merchant3.id)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
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
