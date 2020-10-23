class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def index
    total_revenue = Revenue.total_revenue_by_merchant(params[:id])
    render json: RevenueSerializer.new(total_revenue)
  end
end
