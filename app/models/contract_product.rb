class ContractProduct < ApplicationRecord
    belongs_to :contract, class_name: "Contract", foreign_key: "ContractID"
    belongs_to :product, class_name: "Product", foreign_key: "ProductID"
    
    #Mapping this object to the Database tables
    self.table_name = "contractproduct"
    self.primary_key = "ContractID"
end
