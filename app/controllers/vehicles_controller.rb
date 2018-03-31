class VehiclesController < ApplicationController

    def index
        @vehicles = Vehicle.all


        respond_to do |format|
            format.html
            format.pdf do 
                pdf = VehiclePdf.new(@vehicles)
                send_data pdf.render, filename: "Vehicles List",
                                      type: "application/pdf",
                                      disposition: "inline"
                end
            end
      end

      def show
        @vehicle = Vehicle.find(params[:id])
      end

    def new
        @vehicle = Vehicle.new
    end

    #Update an existing vehicle
    def edit
        @vehicle = Vehicle.find(params[:id])

    end

    #Create an vehicle
    def create
        @vehicle = Vehicle.new(vehicle_params)

        if @vehicle.save
        redirect_to @vehicle
        else
            render 'new'
        end
    end

    #Update the vehicle
    def update
        @vehicle = Vehicle.find(params[:id])
    
        if @vehicle.update(vehicle_params)
            redirect_to @vehicle
        else
            render 'edit'
        end
    end

    #Delete the vehicle
    def destroy
        @vehicle = Vehicle.find(params[:id])
        @vehicle.destroy
        
        redirect_to vehicles_path

    end

    #private function to collect the parameters
    private
    def vehicle_params
        params.require(:vehicle).permit(:VehicleID, :VehicleDescription,
        :LicensePlate, :Weight, :Capacity)
    end
end
