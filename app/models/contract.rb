class Contract < ApplicationRecord

    belongs_to :customer, optional: true, class_name: "Customer", foreign_key: "CustomerID"
    
    has_many :contractproducts, class_name: "ContractProduct", foreign_key: "ContractID"
    has_many :products, :through => :contractproducts 
    has_many :orders, class_name: "Order", foreign_key: "OrderID" 
    #Validation
  
    #Mapping this object to the Database tables
    self.table_name = "contract"
    self.primary_key = "ContractID"

end