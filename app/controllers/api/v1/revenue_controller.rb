class Api::V1::RevenueController < ApplicationController
  def index
    total_revenue = Revenue.total_revenue(params[:start], params[:end])
    render json: RevenueSerializer.new(total_revenue)
  end
end
