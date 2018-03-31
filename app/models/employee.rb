class Employee < ApplicationRecord
#Validation
validates :Firstname,:Lastname,:Phone,:Email,:Street,:City, 
            presence: true

#Mapping this object to the Database tables
    self.table_name = "employee"
    self.primary_key = "EmployeeID"
end
