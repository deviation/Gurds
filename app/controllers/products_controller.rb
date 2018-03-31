class ProductsController < ApplicationController
    def index
        @products = Product.all
        
        respond_to do |format|
            format.html
            format.pdf do 
                pdf = ProductPdf.new(@products)
                send_data pdf.render, filename: "Products List",
                                      type: "application/pdf",
                                      disposition: "inline"
                end
            end
    end

    #Show individual Product
    def show
        @product = Product.find(params[:id])

       
    end

    #Create new Product
    def new
        @product = Product.new
    end

    #Update an existing product
    def edit
    @product = Product.find(params[:id])

    end

    #Create new Product
    def create
        @product = Product.new(product_params)
            
        if @product.save
        redirect_to @product
        else
            render 'new'
        end
    end

    #Update the Product
    def update
        @product = Product.find(params[:id])

        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit'
        end
    end

    #Delete the product
    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        redirect_to products_path
    end

    #Define the needed Parameters, A more secure way to send them.
    private
    def product_params
        params.require(:product).permit(:ProductID, :Category, :Brand, 
        :Description, :Volume, :PackSize, :SKU, :Dimensions, :Weight, :Cost, :Price, :Active)
    end
end
