require 'rails_helper'

RSpec.describe "Item API" do
  it "can update an Item" do
    id = create(:item).id
    previous_name = Item.last.name

    body = {
      name: 'Pen'
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(body)

    updated_item = Item.find_by(id: id)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(updated_item.name).to_not eq(previous_name)
    expect(updated_item.name).to eq(body[:name])

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
