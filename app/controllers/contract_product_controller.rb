class ContractProductController < ApplicationController
    def index
        @contract_product = ContractProduct.all
    
    end

    #Show individual ContractProduct
    def show
        @contract_product = ContractProduct.find(params[:id])

        respond_to do |format|
          format.html
          format.pdf do 
              pdf = ContractPdf.new(@contracts)
              send_data pdf.render, filename: "ContractProduct",
                                    type: "application/pdf",
                                    disposition: "inline"
          end
        end

      end
    
#New ContractProduct
def new

    if(params[:contractID])
       
        @contract_product = ContractProduct.new(ContractID: params[:contractID] )
      else
        @contract_product = ContractProduct.new
      end
  
end
    
      #Update an existing ContractProduct
      def edit
        @contract_product = ContractProduct.find(params[:id])
      end
    
      #Create a new ContractProduct
      def create
        @contract_product = ContractProduct.new(cont_params)
    
        if @contract_product.save
          redirect_to @contract_product
        else
          render 'new'
        end
      end
      
      #Update an ContractProduct
      def update
        @contract_product = ContractProduct.find(params[:id])
        
        if @contract_product.update(cont_params)
          redirect_to @contract_product
        else
          render 'edit'
        end
      end
    
      #Delete an ContractProduct
      def destroy
        @contract_product = ContractProduct.find(params[:id])
        @contract_product.destroy
        
        redirect_to contracts_path
      end
    
      #Define the needed Parameters, A more secure way to send them.
      private
      def cont_params
        params.require(:contract_product).permit(:ContractID, :ProductID, :Quantity)
      end
  
end
