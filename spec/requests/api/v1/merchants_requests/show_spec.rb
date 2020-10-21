require 'rails_helper'

describe "Merchants API" do
  it 'sends a single merchant' do
    merchant1 = create(:merchant, id: 1)

    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)
    create(:item, merchant_id: merchant1.id)

    get "/api/v1/merchants/#{merchant1.id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to be_a(Hash)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:type]).to be_a(String)

    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a(Hash)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)

    expect(merchant[:data]).to have_key(:relationships)
    expect(merchant[:data][:relationships]).to be_a(Hash)

    expect(merchant[:data][:relationships]).to have_key(:items)

    expect(merchant[:data][:relationships]).to be_a(Hash)

    expect(merchant[:data][:relationships][:items]).to have_key(:data)

    expect(merchant[:data][:relationships][:items]).to be_a(Hash)

    items = merchant[:data][:relationships][:items][:data]
    expect(items).to be_an(Array)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")
    end
  end
end
