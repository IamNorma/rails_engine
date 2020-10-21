require 'rails_helper'

describe "Items Merchant" do
  it 'sends a merchant associated with an item' do
    merchant1 = create(:merchant, id: 1)
    merchant2 = create(:merchant, id: 2)

    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/#{item1.id}/merchants"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(merchant1.id.to_s)
    expect(json[:data]).to be_an(Hash)

    merchant = json[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq("merchant")

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)

    expect(merchant[:attributes]).to have_key(:id)
    expect(merchant[:attributes][:id]).to be_an(Integer)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)

    expect(merchant).to have_key(:relationships)
    expect(merchant[:relationships]).to be_a(Hash)
    expect(merchant[:relationships]).to have_key(:items)
    expect(merchant[:relationships][:items]).to be_a(Hash)
    expect(merchant[:relationships][:items]).to have_key(:data)
    expect(merchant[:relationships][:items][:data]).to be_an(Array)
  end
end
