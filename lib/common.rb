module Common
    def getOrderWeight(inOrder)

        order = inOrder
        orderWeight = 0
        
        #find the weight of the order
        #loop through all the products and add their weight together
        order.orderproducts.each do |product|
            amount = product.Quantity
            eachWeight = product.product.Weight
            orderWeight += amount * eachWeight
        end
    
        return orderWeight
    end
    
    def getTruckWeight(inTruckID)

        truck = Vehicle.find(inTruckID)
        route = Route.where('VehicleID = ' + truck.VehicleID.to_s).order(RouteDate: :desc)[0]
        orders = Order.where('RouteID = ' + route.RouteID.to_s)
        truckOrdersWeight = 0
        puts "Orders:" + orders.count.to_s
        orders.each do |order|
            truckOrdersWeight += getOrderWeight(order)
            puts truckOrdersWeight
        end
        puts "total: " + truckOrdersWeight.to_s
        return truckOrdersWeight
    end

    def getTodaysRoutes
        #get the routes for today
        getRoutes = ActiveRecord::Base.connection.exec_query('SELECT RouteID FROM route 
        WHERE RouteDate = "' + today.to_s.split('T')[0] + ' 00:00:00"
        ORDER BY StartTime;')
        return getRoutes
    end 
end