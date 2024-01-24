class V1::OrdersController < ApplicationController

  def index
    # Your code here
  end

  def show

  end

  def create
    order_params = params.permit(:customerId, :customerName, :orderId, :totalInCents,:date)
    if order_params[:date].present?
      order_params[:date] = DateTime.parse(order_params[:date]) # Parse date string into a DateTime object.
    end
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end

  end
end
