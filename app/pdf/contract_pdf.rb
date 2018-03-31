class ContractPdf < Prawn::Document
    def initialize(contracts)
    super()
    @contracts = contracts

    pdf_title
    line_items
    end

    def pdf_title
        text "Contract", size: 30, style: :bold
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
        [["Contract ID", "Customer Name", "Discount", "Start Date", "End Date", 
        "Payment Terms", "Delivery Day Of Week", "Employee ID", "Note", "Commission", "Active"]] +
        @contracts.map do |contract|
            [contract.ContractID.to_s, customer.CustomerName.to_s, contract.Discount.to_s, 
            contract.StartDate.to_s, contract.EndDate.to_s, contract.PaymentTerms.to_s, 
            contract.DeliveryDayOfWeek.to_s, contract.EmployeeID.to_s, contract.Note.to_s, 
            contract.Commission.to_s, contract.Active.to_s] 
        end
    end

end