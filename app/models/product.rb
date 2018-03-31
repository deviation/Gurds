class Product < ApplicationRecord
   
   has_many :contractproducts, class_name: "ContractProduct", foreign_key: "ContractID"
   has_many :contracts, :through => :contractproducts #class_name: "Contract", foreign_key: "ContractID"
   belongs_to :order_products, class_name: "OrderProduct", foreign_key: "ProductID"
   #belongs_to :contractproduct, class_name: "ContractProduct", foreign_key: "ContractID"
    #Validation
    validates :ProductID, :Brand, presence: true
        
    validates :ProductID, 
                uniqueness: true,
                length: { minimum: 5, maximum:5 }
                
    #Mapping this object to the Database tables
    self.table_name = "product"
    self.primary_key = "ProductID"

    #Alias Attributes are used to assign rails variables to the database if they do not match.
    #used these ones while starting to figure out how Rails works.

    #alias_attribute :product_id, :ProductID
    #alias_attribute :brand, :Brand
end
