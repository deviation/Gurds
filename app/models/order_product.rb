class OrderProduct < ApplicationRecord

belongs_to :order, class_name: "Order", foreign_key: "OrderID"
belongs_to :product,  class_name: "Product", foreign_key: "ProductID"

#Mapping this object to the Database tables
self.table_name = "orderproduct"
self.primary_key = "OrderID"

end
