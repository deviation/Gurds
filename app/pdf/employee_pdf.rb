class EmployeePdf < Prawn::Document
    def initialize(employees)
    super()
    @employees = employees

    pdf_title
    line_items
    end

    def pdf_title
        text "Employees List", size: 30, style: :bold
    end

    def line_items
        move_down 20
        table line_item_rows do
            #row(0).font_style = :bold
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
        end
    end

    def line_item_rows
        [["Employee ID", "First Name", "Last Name", "Phone", "Email", "Street", 
        "City", "Province", "Postal", "RoleID", "Active", "Password"]] +
        @employees.map do |employee|
            [employee.EmployeeID.to_s, employee.Firstname.to_s, employee.Lastname.to_s, 
            employee.Phone.to_s, employee.Email.to_s, employee.Street.to_s, employee.City.to_s,
            employee.Province.to_s, employee.Postal.to_s, employee.RoleID.to_s, employee.Active.to_s,
            employee.Password.to_s] 
        end
    end

end