class Api::ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  def index
    @products = Product.all
    if params[:search]
      @products = Product.where("name LIKE ?", "%#{params[:search]}%")  #line needs work
    end
    if params[:discount]
      @products = Product.where("price < ?", 10)
    end
    if params[:sort] == "price"
      if params[:sort_order] == "asc"
        @products = @products.order(:price)
      elsif params[:sort_order] == "desc"
        @products = @products.order(price: :desc)
      end
    else
      @products = @products.order(:id)
    end
    render "all_products.json.jb"
  end

  def show
    @product = Product.find_by(id: params[:id])
    render "query_find.json.jb"
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      supplier_id: params[:supplier_id]
    )
    if @product.save # Happy path
      render "query_find.json.jb"
    else #sad path
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    if @product.save # Happy path
      render "query_find.json.jb"
    else # Sad path
      render json: {errors:product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: {message: "Recipe successfully destroyed!"}
  end

end
