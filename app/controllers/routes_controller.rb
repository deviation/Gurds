class RoutesController < ApplicationController
    helper Common

    def index
        @routes = Route.all
       
       
    end

    #Show individual route
    def show
        @route = Route.find(params[:id])

    end

    #Create new route
    def new
        @route = Route.new
    end

    #Update an existing route
    def edit
    @route = Route.find(params[:id])

    end

    #Create new route
    def create
        @route = Route.new(route_params)
            
        if @route.save
        redirect_to @route
        else
            render 'new'
        end
    end

    #Update the route
    def update
        @route = Route.find(params[:id])

        if @route.update(route_params)
            redirect_to @route
        else
            render 'edit'
        end
    end

    #Delete the route
    def destroy
        @route = Route.find(params[:id])
        @route.destroy

        redirect_to routes_path
    end

    #Define the needed Parameters, A more secure way to send them.
    private
    def route_params
        params.require(:route).permit(:RouteID, :RouteDate, :VehicleID, 
        :EmployeeID, :Note, :StartTime, :CompleteTime )
    end

    
end
