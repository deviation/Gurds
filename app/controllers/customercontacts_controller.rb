class CustomercontactsController < ApplicationController

  #Get all Customercontacts from database
  def index
    @customercontacts = Customercontact.all


    respond_to do |format|
      format.html
      format.pdf do 
          pdf = CustomercontactPdf.new(@customercontacts)
          send_data pdf.render, filename: "Customercontact List",
                                type: "application/pdf",
                                disposition: "inline"
          end
      end
  end

  #Show individual Customercontact
  def show
    @customercontact = Customercontact.find(params[:id])
  end

  #New Customercontact
  def new
    @customercontact = Customercontact.new
  end

  #Update an existing Customercontact
  def edit
    @customercontact = Customercontact.find(params[:id])
  end

  #Create a new Customercontact
  def create
    @customercontact = Customercontact.new(contact_params)

    if @customercontact.save
      redirect_to @customercontact
    else
      render 'new'
    end
  end
  
  #Update an Customercontact
  def update
    @customercontact = Customercontact.find(params[:id])
    
    if @customercontact.update(contact_params)
      redirect_to @customercontact
    else
      render 'edit'
    end
  end

  #Delete an Customercontact
  def destroy
    @customercontact = Customercontact.find(params[:id])
    @customercontact.destroy
    
    redirect_to customercontacts_path
  end

  #Define the needed Parameters, A more secure way to send them.
  private
  def contact_params
    params.require(:Customercontact).permit(:ContactID, :CustomerID, :Firstname, :Lastname,
    :Phone, :Email, :Street, :City, :Province, :Postal, :Note)
  end

end
