class V1::CustomersController < ApplicationController
  #before_action :invalidate_customer_cache, only: [:show]

  def show
    @customer = Customer.find(params[:id])
    p @customer
    render json: @customer
  end

  private

  def invalidate_customer_cache
    customer = Customer.find(params[:id])
    customer.invalidate_customer_cache
  end
end
