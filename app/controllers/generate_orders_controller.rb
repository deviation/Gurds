class GenerateOrdersController < ApplicationController

    include Common

    def index

        if params['q']

            today = DateTime.now
            #hold our chosen date
            date = params['q']['date']

            #Find what the Day of the week is from the chosen date
            dayOfWeek = Date.parse(date).strftime('%A')

            #Find all contracts on that day
            contractsForDay = Contract.where(DeliveryDayOfWeek: dayOfWeek)
            puts "ContractDAy: " + contractsForDay.to_s
            #Loop through and do stuff
            contractsForDay.each do |contract|
                #create each order for that particular day
                thisOrder = Order.create(CustomerID: contract.CustomerID, DateOrdered: today, DeliveryDate: date, 
                EmployeeID: contract.EmployeeID, OrderType: 'CONTRACT', Status: 'Ordered', Note: contract.Note, 
                RouteID: '', ContractID: contract.ContractID)
                puts "Created Order=========> " + thisOrder.inspect
                #populate products into each order as they are made
                thisOrder.contract.contractproducts.each do |product|
                    OrderProduct.create(OrderID: thisOrder.OrderID, ProductID: product.ProductID, Quantity: product.Quantity).save!
                end    

            end

            #Number of orders in each zone Zones organized by the busiest zones
            zones = ActiveRecord::Base.connection.exec_query("select count(*) as Orders,Zone.ZoneID from orders 
            JOIN contract on orders.ContractID = contract.ContractID 
            JOIN customer on contract.CustomerID = customer.CustomerID 
            JOIN Zone on customer.ZoneID = Zone.ZoneID 
            WHERE Orders.DeliveryDate >='" + date.split(' ')[0] + " 00:00:00' AND Orders.DeliveryDate <='" + date.split(' ')[0] + " 23:59:59' 
            GROUP BY Zone.ZoneID 
            ORDER BY Orders desc;")

            #find all the vehicles and order them in descending order
            vehicles = Vehicle.where('Capacity > 0 AND Active = 1').order(Weight: :desc) 

            #for each order id in zone, assign that order to a vehicle
            vehicles.each do |vehicle|

                #create a route
                thisRoute = Route.create(RouteDate: date, VehicleID: vehicle.VehicleID,
                EmployeeID: getNextFreeDriverID(date), StartTime: date, CompleteTime: today.end_of_day )         
                puts "creating route: " + thisRoute.RouteID.to_s + ", Vehicle ID:" + thisRoute.VehicleID.to_s  
                #Order IDs in the each Zone

                foundProductsInZone = false

                zones.rows.each do |zone|
                    #keep track of the zone we are in, if we have been in it already 
                    #then break out and go into the next vehicle.
                    if foundProductsInZone 
                        break
                    end

                    #select all the orders in this Zone
                    puts "ZoneID:" + zone[1]
                    orderIDs = ActiveRecord::Base.connection.exec_query("select OrderID from Orders join customer 
                    on Orders.CustomerId = Customer.CustomerID where Customer.ZoneID ='" + zone[1] + "'" )
                    totalRouteWeight = 0
                    nextOrder = 0
                    currentLoad = 0

                    #loop through orders to put in truck
                    orderIDs.each do |orderID|

                        puts "OrderID:" + orderID.to_s
                        #only add routes as long as they dont already exist
                        
                        thisOrder = Order.find(orderID['OrderID'])
                       
                        puts "thisOrder========>> " + thisOrder.inspect
                        if  thisOrder.RouteID == nil

                            nextOrder = getOrderWeight thisOrder
                            totalRouteWeight += nextOrder
                            currentLoad = getTruckWeight vehicle.VehicleID

                            payloadCapacity = vehicle.Weight

                            if (currentLoad + nextOrder) < (payloadCapacity * 0.66)
                              puts "thisOrder:--->" + thisOrder.inspect
                                thisOrder.RouteID = thisRoute.RouteID
                                thisOrder.save!
                                puts "thisOrder:--->" + thisOrder.inspect
                                #tells us we went into this zone
                                foundProductsInZone = true
                            end
                        end
                           
                    end
                   
                end

            end
        
            redirect_to routes_path
        end
    end

    #Check each driver to see if they are available to deliver the current route
    #loop through all routes for each driver until a driver who isnt busy is found
    def getNextFreeDriverID(date)
        #find the routes only on the day chosen 
        todaysRoutes = Route.where(RouteDate: date)
        #grab the drivers by the bottles
        drivers = Employee.where(RoleID: 'Driver')

        drivers.each do |driver|
            busyDriver = false
            #find a driver not on a route
             
            todaysRoutes.each do |route|
                if route.EmployeeID == driver.EmployeeID
                    busyDriver = true
                    break
                end
            end 
            #if driver isnt busy then he can drive this truck
            if busyDriver == false
                #assign this driver to the route
                return driver.EmployeeID
            end   
        end
    end
      
end
