class Api::ProductsController < ApplicationController
  def product_list
    @products_list = Product.all
    render json: @products_list
  end
end
