class Api::OrdersController < ApplicationController
  before_action :authenticate_user, only: [:index, :create]
  def index
    @orders = current_user.orders
    render "index.json.jb"
  end
  
  def create
  #   product = Product.find_by(id: params[:product_id])
  #   calc_subtotal = product.price * params[:quantity].to_i
  #   calc_tax = calc_subtotal * 0.07
  #   calc_total = calc_subtotal + calc_tax
  #   @order = Order.new(
  #     user_id: current_user.id,
  #     product_id: params[:product_id],
  #     quantity: params[:quantity],
  #     subtotal: calc_subtotal,
  #     tax: calc_tax,
  #     total: calc_total
  # )
    carted_products = current_user.carted_products.where(status: "carted")
    subtotal = 0
    carted_products.each do |carted_product|
      calc_subtotal += carted_product.product.price * carted_product.quantity
      carted_product.update(status: "purchased")
    end
    
    calc_tax = calc_subtotal * 0.09

    @order = Order.new(
      user_id: current_user.id,
      subtotal: calc_subtotal,
      tax: calc_tax,
      total: calc_subtotal + calc_tax
    )
    if @order.save
      # @order.subtotal = @order.product.price * @order.quantity
      # @order.tax = @order.subtotal * 0.07
      # @order.total = @order.subtotal + @order.tax
      # @order.update(
      #   subtotal: @order.subtotal,
      #   tax: @order.tax,
      #   total: @order.total
      # )
      # render "show.json.jb"
      render json: {message: "Success!"}
    else
      render json: {errors: @order.errors.full_messages}, status: :bad_request
    end
  end

  def show 
    @order = Order.find(params[:id])
    render "show.json.jb"
  end
end