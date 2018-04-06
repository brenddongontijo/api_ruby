class ProductsController < ApplicationController
  include Response
  include ExceptionHandler
  include FreightHandler

  before_action :set_product, only: [:show, :update, :destroy, :get_freight]

  # Endpoint GET /products
  def index
    @products = Product.all
    json_response(@products)
  end

  # Endpoint POST /products
  def create
    @product = Product.create!(product_params)
    json_response(@product, :created)
  end

  # Endpoint GET /products/:id
  def show
    json_response(@product)
  end

  # Endpoint PUT /products/:id
  def update
    @product.update!(product_params)
    head :no_content
  end

  # Endpoint DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  # Endpoint GET /products/:id/freight
  def get_freight
    json_response(calculate_freight(@product))
  end


  private

  def product_params
    params.permit(:name, :description, :value, :height, :weight, :width, :length)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
