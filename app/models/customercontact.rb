class Customercontact < ApplicationRecord

    belongs_to :customer, class_name: "Customer", foreign_key: "CustomerID"

    #Validation
   
    #Mapping this object to the Database tables
        self.table_name = "customercontact"
        self.primary_key = "ContactID"

end
