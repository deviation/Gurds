class Route < ApplicationRecord

        has_many :orders, class_name: "Order", foreign_key: "RouteID"
        has_many :products, :through =>  :orderproducts
        has_many :contractproducts, :through =>  :orderproducts
    
            #Mapping this object to the Database tables
            self.table_name = "route"
            self.primary_key = "RouteID"

end
