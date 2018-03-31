class OrderProductsController < ApplicationController

 #Get all order_products from database
  def index
    @order_products = OrderProduct.all

  end

  #Show individual order_product
  def show
    @order_product = OrderProduct.find(params[:id])
  end

  #New order_product
  def new
    @order_product = OrderProduct.new
  end

  #Update an existing order_product
  def edit
    @order_product = OrderProduct.find(params[:id])
    #@order = 
    #@order_products = OrderProduct.where('OrderID = ' + params[:id])
    #@products = Product.all
  end

  #Create a new order_product
  def create
    @order_product = OrderProduct.new(order_product_params)

    if @order_product.save
      redirect_to @order_product
    else
      render 'new'
    end
  end
  
  #Update an order_product
  def update
    @order_product = OrderProduct.find(params[:id])
    
    if @order_product.update(order_product_params)
      redirect_to @order_product
    else
      render 'edit'
    end
  end

  #Delete an order_product
  def destroy
    @order_product = OrderProduct.find(params[:id])
    @order_product.destroy
    
    redirect_to order_products_path
  end

  #Define the needed Parameters, A more secure way to send them.
  private
  def order_product_params
    params.require(:order_product).permit(:OrderID, :ProductID, :Quantity)
  end

end
