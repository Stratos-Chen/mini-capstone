class Api::ProductsController < ApplicationController
  def product_list
    @products_list = Product.all
    render json: @products_list
  end

  def product_one
    @find_product = Product.find_by(id: 1)
    render json: @find_product
  end

  def product_two
    @find_product = Product.find_by(id: 2)
    render json: @find_product
  end

  def product_three
    @find_product = Product.find_by(id: 3)
    render json: @find_product
  end
end
