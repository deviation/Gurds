class VehiclePdf < Prawn::Document
    def initialize(vehicles)
    super()
    @vehicles = vehicles

    pdf_title
    line_items
    end

    def pdf_title
        text "Vehicles List", size: 30, style: :bold
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
        [["Vehicle ID", "Description", "License Plate", "Weight", "Capacity", "Active"]] +
        @vehicles.map do |vehicle|
            [vehicle.VehicleID.to_s, vehicle.VehicleDescription.to_s, vehicle.LicensePlate.to_s, 
            vehicle.Weight.to_s, vehicle.Capacity.to_s, vehicle.Active.to_s] 
        end
    end

end
