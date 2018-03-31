class Vehicle < ApplicationRecord
    #Validation
    validates :VehicleID,       
                presence: true,
                uniqueness: true,
                numericality: { only_integer: true },
                format: { with: /\A\d+\z/, message: "Integer only. No sign allowed."}  

#Mapping this object to the Database tables
self.table_name = "vehicle"
self.primary_key = "VehicleID"

end
