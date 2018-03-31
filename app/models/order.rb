class Order < ApplicationRecord

    belongs_to :route, optional: true, class_name: "Route", foreign_key: "RouteID" 
    belongs_to :customer, class_name: "Customer", foreign_key: "CustomerID"
    belongs_to :contract, class_name: "Contract", foreign_key: "ContractID"
    has_many :orderproducts, class_name: "OrderProduct", foreign_key: "OrderID"
    has_many :products, :through => :orderproducts

    #Mapping this object to the Database tables
    self.table_name = "orders"
    self.primary_key = "OrderID"

end
