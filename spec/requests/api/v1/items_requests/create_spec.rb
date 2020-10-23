require 'rails_helper'

RSpec.describe "Item API" do
  it "can create a new item" do
    create(:merchant, id: 2)

    body = {
      name: 'Pencil',
      description: 'Great tool for writing',
      unit_price: 2.50,
      merchant_id: 2
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(body)

    json = JSON.parse(response.body, symbolize_names: true)

    last_item = Item.last

    expect(response).to be_successful
    expect(last_item.name).to eq(body[:name])
    expect(last_item.description).to eq(body[:description])
    expect(last_item.unit_price).to eq(body[:unit_price])
    expect(last_item.merchant_id).to eq(body[:merchant_id])

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
end
