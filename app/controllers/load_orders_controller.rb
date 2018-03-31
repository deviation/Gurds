class LoadOrdersController < ApplicationController
    
    include Common
    
    def index

        #get todays date
        today = Date.Now
        
       routes = getTodaysRoutes
        #create an array of 
        bays[1,2,3,4]
        theBay = ''
        #go into each bay and assign it orders and products
        bays.each do |loadBay|

            #assign theBay to the current bay we are in
            theBay = bays[loadBay]
            #go through the routes and find all the products in it.
            getRoutes.each do |route|

             thisRoute = Route.find(route("RouteID"))


            end
        end
    end
end
