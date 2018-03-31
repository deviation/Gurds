class Customer < ApplicationRecord

    has_many :contracts, class_name: "Contract", foreign_key: "CustomerID"
    has_many :customercontacts, class_name: "Customercontact", foreign_key: "CustomerID"
    has_many :customernotes, class_name: "Customernote", foreign_key: "CustomerID"
    has_many :orders, class_name: "Order", foreign_key: "CustomerID"
    #Validation
    #validates :CustomerID, :CustomerTypeID, presence: true
    has_secure_password
    #validates :CustomerID, uniqueness: true

    #Mapping this object to the Database tables
    self.table_name = "customer"
    self.primary_key = "CustomerID"
end
