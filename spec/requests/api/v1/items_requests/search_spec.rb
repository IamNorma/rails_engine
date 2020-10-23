require 'rails_helper'

describe "Items Search API" do
  before(:each) do
    item1 = create(:item, name: "Walmart")
    item2 = create(:item, name: "Turing")
    item3 = create(:item, name: "Ring World")
  end
  it 'can find a single item that contains a fragment, case insensitive' do

    get "/api/v1/items/find?name=ring"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:description)
    expect(json[:data][:attributes][:description]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:unit_price)
    expect(json[:data][:attributes][:unit_price]).to be_a(Float)
    expect(json[:data][:attributes]).to have_key(:merchant_id)
    expect(json[:data][:attributes][:merchant_id]).to be_an(Integer)

    expect(json[:data]).to have_key(:relationships)
    expect(json[:data][:relationships]).to be_a(Hash)
    expect(json[:data][:relationships]).to have_key(:merchant)
    expect(json[:data][:relationships]).to be_a(Hash)
    expect(json[:data][:relationships][:merchant]).to have_key(:data)
  end

  it 'can find a list of items that contains a fragment, case insensitive' do

    get "/api/v1/items/find_all?name=ring"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(2)

    json[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:attributes)
      expect(item).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
      expect(item).to have_key(:relationships)
      expect(item).to be_a(Hash)
      expect(item[:relationships]).to have_key(:merchant)
      expect(item[:relationships][:merchant]).to be_a(Hash)
      expect(item[:relationships][:merchant]).to have_key(:data)
      expect(item[:relationships][:merchant][:data]).to be_a(Hash)
    end
  end
end
