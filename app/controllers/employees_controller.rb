class EmployeesController < ApplicationController
  #Get all employees from database
  def index
    @employees = Employee.all


    respond_to do |format|
      format.html
      format.pdf do 
          pdf = EmployeePdf.new(@employees)
          send_data pdf.render, filename: "Employee List",
                                type: "application/pdf",
                                disposition: "inline"
          end
      end
  end

  #Show individual Employee
  def show
    @employee = Employee.find(params[:id])
  end

  #New Employee
  def new
    @employee = Employee.new
  end

  #Update an existing Employee
  def edit
    @employee = Employee.find(params[:id])
  end

  #Create a new Employee
  def create
    @employee = Employee.new(employ_params)

    if @employee.save
      redirect_to @employee
    else
      render 'new'
    end
  end
  
  #Update an employee
  def update
    @employee = Employee.find(params[:id])
    
    if @employee.update(employ_params)
      redirect_to @employee
    else
      render 'edit'
    end
  end

  #Delete an Employee
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    
    redirect_to employees_path
  end

  #Define the needed Parameters, A more secure way to send them.
  private
  def employ_params
    params.require(:employee).permit(:EmployeeID, :Firstname, :Lastname,
    :Phone, :Email, :Street, :City, :Province, :Postal, :RoleID, :Active, :Password)
  end
  
end
