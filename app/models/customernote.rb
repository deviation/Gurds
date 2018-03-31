class Customernote < ApplicationRecord

belongs_to :customer, class_name: "Customer", foreign_key: "CustomerID"

    #Mapping this object to the Database tables
    self.table_name = "customernote"
    self.primary_key = "NoteID"

end
