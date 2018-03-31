class OrdersController < ApplicationController

 #Get all orders from database
 def index
    @orders = Order.all
    @contracts = Contract.all

  end

  #Show individual order
  def show
    @order = Order.find(params[:id])
    #@contract = Contract.all
  end

  #New order
  def new
    @order = Order.new
  end

  #Update an existing order
  def edit
    @order = Order.find(params[:id])
  end

  #Create a new order
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order
    else
      render 'new'
    end
  end
  
  #Update an order
  def update
    @order = Order.find(params[:id])
    
    if @order.update(order_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  #Delete an order
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    
    redirect_to orders_path
  end

  #Define the needed Parameters, A more secure way to send them.
  private
  def order_params
    params.require(:order).permit(:OrderID, :CustomerID, :DateOrdered,
    :DeliveryDate, :EmployeeID, :OrderType, :Status, :Note, :RouteID)
  end

end
