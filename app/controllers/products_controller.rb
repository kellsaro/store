class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    return redirect_to(@product) if @product.save

    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update
    return redirect_to(@product) if @product.update(product_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  private
    def product_params
      params.expect(product: [:name, :description])
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
