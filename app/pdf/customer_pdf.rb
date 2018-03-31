class CustomerPdf < Prawn::Document
    def initialize(customers)
    super()
    @customers = customers

    pdf_title
    line_items
    end

    def pdf_title
        text "Customers List", size: 30, style: :bold
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
        [["Customer ID", "Customer Name", "Street", "City", "Province", 
        "Postal", "Phone", "Email", "ZoneID", "Start Date", "Note", "Customer Type ID"]] +
        @customers.map do |customer|
            [customer.CustomerID.to_s, customer.CustomerName.to_s, customer.Street.to_s, 
            customer.City.to_s, customer.Province.to_s, customer.Postal.to_s, 
            customer.Phone.to_s, customer.Email.to_s, customer.ZoneID.to_s, 
            customer.StartDate.to_s, customer.Note.to_s, customer.CustomerTypeID.to_s] 
        end
    end

end