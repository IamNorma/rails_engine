require 'rails_helper'

describe "Merchants Search API" do
  before(:each) do
    merchant1 = create(:merchant, name: "Walmart")
    merchant2 = create(:merchant, name: "Turing")
    merchant3 = create(:merchant, name: "Ring World")
  end
  it 'can find a single merchant that contains a fragment, case insensitive' do

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

  it 'can find a list of merchants that contains a fragment, case insensitive' do

    get "/api/v1/merchants/find_all?name=ring"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(2)

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
    end
  end
end
