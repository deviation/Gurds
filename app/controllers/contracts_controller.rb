class ContractsController < ApplicationController
    def index
      #@customer = Customer.all
      @contracts = Contract.all
      
    end
    
      #Show individual Contract
      def show
        @contract = Contract.find(params[:id])

        respond_to do |format|
          format.html
          format.pdf do 
              pdf = ContractPdf.new(@contracts)
              send_data pdf.render, filename: "Contract",
                                    type: "application/pdf",
                                    disposition: "inline"
          end
        end

      end
    
#New Contract
def new
  if(params[:customerID])
    #puts "CUSTOMERID " + params[:customerID]
    @contract = Contract.new(CustomerID: params[:customerID])
  else
    @contract = Contract.new
  end
  
end
    
      #Update an existing Contract
      def edit
        @contract = Contract.find(params[:id])
      end
    
      #Create a new Contract
      def create
        @contract = Contract.new(cont_params)
    
        if @contract.save
          redirect_to @contract
        else
          render 'new'
        end
      end
      
      #Update an Contract
      def update
        @contract = Contract.find(params[:id])
        
        if @contract.update(cont_params)
          redirect_to @contract
        else
          render 'edit'
        end
      end
    
      #Delete an Contract
      def destroy
        @contract = Contract.find(params[:id])
        @contract.destroy
        
        redirect_to contracts_path
      end
    
      #Define the needed Parameters, A more secure way to send them.
      private
      def cont_params
        params.require(:contract).permit(:ContractID, :CustomerID, :Discount, :StartDate, :EndDate, 
        :PaymentTerms, :DeliveryDayOfWeek, :EmployeeID, :Note, :Commission, :Active)
      end
  
end
