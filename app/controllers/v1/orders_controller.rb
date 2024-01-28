class V1::OrdersController < ApplicationController

  def index
    # Your code here
  end

  def show

  end

def create
  order_params = params.permit(:customerId, :customerName, :orderId, :totalInCents, :date)

  if order_params[:date].present?
    order_params[:date] = DateTime.parse(order_params[:date]) # Parse date string into a DateTime object.
  end

  # Convert customerId to customer_id
  customer_id = order_params[:customerId]
  order_params[:customer_id] = customer_id.to_i if customer_id.present?

  # Find the customer
  customer = Customer.find_by(id: order_params[:customer_id])

  if customer.present?
    # Attach order to customer
    @order = customer.orders.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  else
    render json: { errors: ['Customer not found'] }, status: :unprocessable_entity
  end
end

end
