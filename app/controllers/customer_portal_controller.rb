class CustomerPortalController < ApplicationController

    #Get all customers from database
    def index

        @customers = Customer.all
        #@contracts = Contract.all

        respond_to do |format|
        format.html
        format.pdf do 
            pdf = CustomerPdf.new(@customers)
            send_data pdf.render, filename: "Customers List",
                                    type: "application/pdf",
                                    disposition: "inline"
            end
        end

        if true
            render 'sales'
        else
            render 'index'
        end 

    end

    #Show Contacts
    def contacts
        @customer = Customer.find(params[:id])
    end

    #Show Notes
    def notes
        @customer = Customer.find(params[:id])
    end

    #Show individual Customer
    def show
        @customer = Customer.find(params[:id])
    end
    
    #New Customer
    def new
        @customer = Customer.new
    end
    
    #Update an existing Customer
    def edit
        @customer = Customer.find(params[:id])
    end
    
    #Create a new Customer
    def create
        @customer = Customer.new(cust_params)
    
        if @customer.save
        redirect_to "/contracts/new?customerID=" + String(@customer.CustomerID)
        else
        render 'new'
        end
    end
    
    #Update an customer
    def update
        @customer = Customer.find(params[:id])
        
        if @customer.update(cust_params)
        redirect_to @customer
        else
        render 'edit'
        end
    end
    
    #Delete an Customer
    def destroy
        @customer = Customer.find(params[:id])
        @customer.destroy
        
        redirect_to customers_path
    end
    
    #Define the needed Parameters, A more secure way to send them.
    private
    def cust_params
        params.require(:customer).permit(:CustomerID, :CustomerName, :Street, :City, :Province, 
        :Postal, :Phone, :Email, :ZoneID, :StartDate, :Note, :CustomerTypeID)
    end
    
end
