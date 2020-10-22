require 'rails_helper'

describe "Merchants Search API" do
  it 'can find a single merchant that contains a fragment, case insensitive' do
    merchant1 = create(:merchant, name: "Walmart")
    merchant2 = create(:merchant, name: "Turing")

    get "/api/v1/merchants/find?name=ring"

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

    expect(json[:data]).to have_key(:relationships)
    expect(json[:data][:relationships]).to be_a(Hash)

    expect(json[:data][:relationships]).to have_key(:items)

    expect(json[:data][:relationships]).to be_a(Hash)

    expect(json[:data][:relationships][:items]).to have_key(:data)

    expect(json[:data][:relationships][:items]).to be_a(Hash)
  end
end
