class SessionsController < ApplicationController
  def new
  end

  def create
    user = Customer.find_by(Email: params[:session][:email])
    if !user
      user = Employee.find_by(Email: params[:session][:email])
    end

    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      if user.is_a?(Customer)
        redirect_to customer_path(user)
      else 
        redirect_to root_path
      end

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
