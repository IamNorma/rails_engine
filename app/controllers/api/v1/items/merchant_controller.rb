class Api::V1::Items::MerchantController < ApplicationController
  def show
    item = Item.find(params[:id])
    merchant = Merchant.where(id: item.merchant_id).first
    render json: MerchantSerializer.new(merchant)
  end
end
