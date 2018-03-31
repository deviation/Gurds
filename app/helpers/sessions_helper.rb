module SessionsHelper
    
    # Logs in the given customer.
    def log_in(customer)
        session[:customer_id] = customer.id
    end 

      # Returns the current logged-in customer (if any).
  def current_customer
    @current_customer ||= Customer.find_by(CustomerID: session[:customer_id])
  end

  # Returns true if the customer is logged in, false otherwise.
  def logged_in?

      !current_customer.nil?

  end

  def log_out

    session.delete(:customer_id)
    @current_customer = nil
  end

end
