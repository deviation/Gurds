module SessionsHelper
    
    # Logs in the given customer.
    def log_in(user)
        session[:user_id] = user.id
        if user.is_a?(Customer)
          session[:user_id] = user.CustomerID
          session[:user_role] = 'Customer'
        else
          if user.is_a?(Employee)
            session[:user_id] = user.EmplyeeID
            session[:user_role] = user.RoleID
          end
        end
    end 

      # Returns the current logged-in user (if any).
    def current_user
      if session[:user_role] = 'Customer'
         @current_user ||= Customer.find_by(CustomerID: session[:user_id])
      else
         @current_user ||= Employee.find_by(EmployeeID: session[:user_id])
      end
    end

    # Returns true if the customer is logged in, false otherwise.
    def logged_in?
      puts "logged_in?"
      !current_user.nil?
    end

    def is_employee?
      puts "is_employee current_user[:role_id] : " + current_user[:role_id].to_s
      return session[:user_role] != 'Customer'
    end

    def log_out
      session.delete(:user_id)
      session.delete(:user_role)
      @current_user = nil
    end


end
