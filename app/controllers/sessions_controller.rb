class SessionsController < ApplicationController
  def new
  end

  def create

    customer = Customer.find_by(Email: params[:session][:email])
    
puts "customer password: " + customer.password_digest
    if customer.authenticate(params[:session][:password])
      puts "Customer Logged in: " + params[:session][:email]
            # Log the user in and redirect to the user's show page.
      log_in customer
      redirect_to customer_path(customer)

    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end

  end

  def destroy

    log_out
    redirect_to root_url

  end

end
