class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = params.keys.first
    query = params[attribute]
    merchant = if attribute == 'name'
                 Merchant.where("lower(#{attribute}) LIKE ?", "%#{query.downcase}%").first
               elsif attribute == 'created_at' || attribute == 'updated_at'
                 Merchant.where("CAST(#{attribute} AS text) LIKE ?", "%#{query.downcase}%").first
               end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    attribute = params.keys.first
    query = params[attribute]
    merchants = if attribute == 'name'
                 Merchant.where("lower(#{attribute}) LIKE ?", "%#{query.downcase}%")
               elsif attribute == 'created_at' || attribute == 'updated_at'
                 Merchant.where("CAST(#{attribute} AS text) LIKE ?", "%#{query.downcase}%")
               end
    render json: MerchantSerializer.new(merchants)
  end
end
