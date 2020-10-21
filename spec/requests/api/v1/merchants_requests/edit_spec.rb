require 'rails_helper'

RSpec.describe "Merchant API" do
  it "can update a merchnant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name

    body = {
      name: 'Target'
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(body)

    updated_merchant = Merchant.find_by(id: id)

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(updated_merchant.name).to_not eq(previous_name)
    expect(updated_merchant.name).to eq(body[:name])

    expect(merchant[:data]).to be_a(Hash)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data][:type]).to be_a(String)

    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a(Hash)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
