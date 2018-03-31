# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "brand", primary_key: "BrandID", id: :string, limit: 25, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
  end

  create_table "category", primary_key: "Category", id: :string, limit: 10, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "Description", limit: 50
  end

  create_table "contract", primary_key: "ContractID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "CustomerID", default: 0, null: false
    t.integer "Discount", default: 0, null: false
    t.datetime "StartDate", null: false
    t.datetime "EndDate"
    t.string "PaymentTerms", default: "Net 30 Days", null: false
    t.string "DeliveryDayOfWeek", limit: 10, null: false
    t.integer "EmployeeID", default: 0, null: false
    t.string "Note"
    t.integer "Commission", default: 0
    t.boolean "Active", default: true
    t.index ["CustomerID"], name: "CustomerID"
    t.index ["EmployeeID"], name: "EmployeeID"
  end

  create_table "contractproduct", primary_key: ["ContractID", "ProductID"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "ContractID", null: false
    t.integer "ProductID", null: false
    t.integer "Quantity", null: false
    t.index ["ProductID"], name: "ProductID"
  end

  create_table "customer", primary_key: "CustomerID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "CustomerName", null: false
    t.string "Street", null: false
    t.string "City", null: false
    t.string "Province", limit: 2, default: "NB", null: false
    t.string "Postal", limit: 10, null: false
    t.string "Phone", limit: 25, null: false
    t.string "Email", limit: 50
    t.string "Password"
    t.string "ZoneID", limit: 10
    t.datetime "StartDate"
    t.string "Note"
    t.string "CustomerTypeID", limit: 15
    t.index ["CustomerName"], name: "CustomerName"
    t.index ["CustomerTypeID"], name: "CustomerTypeID"
    t.index ["ZoneID"], name: "ZoneID"
  end

  create_table "customercontact", primary_key: "ContactID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "CustomerID", default: 0, null: false
    t.string "Firstname", limit: 25, null: false
    t.string "Lastname", limit: 25, null: false
    t.string "Phone", limit: 25
    t.string "Email", limit: 50
    t.string "Street", null: false
    t.string "City", null: false
    t.string "Province", limit: 2, null: false
    t.string "Postal", limit: 6, null: false
    t.string "Note"
    t.index ["CustomerID"], name: "CustomerID"
    t.index ["Province"], name: "Province"
  end

  create_table "customernote", primary_key: "NoteID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "CustomerID", default: 0, null: false
    t.integer "EmployeeID", default: 0, null: false
    t.datetime "NoteDateTime", null: false
    t.string "NoteTypeID", limit: 10, null: false
    t.string "Note", limit: 2000, null: false
    t.datetime "ResolutionDateTime"
    t.string "Resolution"
    t.boolean "Resolved", default: false
    t.index ["CustomerID"], name: "CustomerID"
    t.index ["EmployeeID"], name: "EmployeeID"
    t.index ["NoteTypeID"], name: "NoteTypeID"
  end

  create_table "customertype", primary_key: "CustomerTypeID", id: :string, limit: 15, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "CustomerTypeDescription", null: false
    t.index ["CustomerTypeID"], name: "CustomerTypeID", unique: true
  end

  create_table "employee", primary_key: "EmployeeID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "Firstname", limit: 25, null: false
    t.string "Lastname", limit: 25, null: false
    t.string "Phone", limit: 25
    t.string "Email", limit: 50
    t.string "Password"
    t.string "Street", null: false
    t.string "City", null: false
    t.string "Province", limit: 2, default: "NB", null: false
    t.string "Postal", limit: 10, null: false
    t.string "RoleID", limit: 25
    t.boolean "Active", default: true
    t.index ["RoleID"], name: "RoleID"
  end

  create_table "notetype", primary_key: "NoteTypeID", id: :string, limit: 10, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "Description", limit: 25, null: false
  end

  create_table "orderproduct", primary_key: ["OrderID", "ProductID"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "OrderID", null: false
    t.integer "ProductID", null: false
    t.integer "Quantity", null: false
    t.index ["ProductID"], name: "ProductID"
  end

  create_table "orders", primary_key: "OrderID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "CustomerID", null: false
    t.datetime "DateOrdered"
    t.datetime "DeliveryDate"
    t.integer "EmployeeID", default: 0, null: false
    t.string "OrderType", limit: 10
    t.string "Status", limit: 25
    t.string "Note"
    t.integer "RouteID", default: 0
    t.index ["CustomerID"], name: "CustomerID"
    t.index ["EmployeeID"], name: "EmployeeID"
  end

  create_table "product", primary_key: "ProductID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "Category", limit: 10, null: false
    t.string "Brand", limit: 50, null: false
    t.string "Description", null: false
    t.string "Volume", null: false
    t.string "PackSize", null: false
    t.string "SKU", null: false
    t.float "Dimensions", limit: 53, default: 0.0, null: false
    t.float "Weight", limit: 53, default: 0.0, null: false
    t.decimal "Cost", precision: 19, scale: 4, default: "0.0"
    t.decimal "Price", precision: 19, scale: 4, default: "0.0"
    t.boolean "Active", default: true
    t.index ["Brand"], name: "Brand"
    t.index ["Category"], name: "Category"
    t.index ["SKU"], name: "SKU", unique: true
  end

  create_table "province", primary_key: "Province", id: :string, limit: 2, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "Description", null: false
  end

  create_table "role", primary_key: "RoleID", id: :string, limit: 25, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "Description", null: false
    t.boolean "Active", default: true
  end

  create_table "route", primary_key: "RouteID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "RouteDate", null: false
    t.integer "VehicleID", default: 0
    t.integer "EmployeeID", default: 0
    t.string "Note"
    t.datetime "StartTime"
    t.datetime "CompleteTime"
    t.index ["EmployeeID"], name: "EmployeeID"
    t.index ["VehicleID"], name: "VehicleID"
  end

  create_table "vehicle", primary_key: "VehicleID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "VehicleDescription", null: false
    t.string "LicensePlate", limit: 10, null: false
    t.integer "Weight", default: 0, null: false
    t.integer "Capacity", default: 0, null: false
    t.boolean "Active", default: true
    t.index ["LicensePlate"], name: "LicensePlate"
  end

  create_table "zone", primary_key: "ZoneID", id: :string, limit: 10, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "ZoneDescription", null: false
    t.boolean "Active", default: true
  end

  add_foreign_key "contract", "customer", column: "CustomerID", primary_key: "CustomerID", name: "contract_ibfk_1"
  add_foreign_key "contract", "employee", column: "EmployeeID", primary_key: "EmployeeID", name: "contract_ibfk_2"
  add_foreign_key "contractproduct", "contract", column: "ContractID", primary_key: "ContractID", name: "contractproduct_ibfk_2"
  add_foreign_key "contractproduct", "product", column: "ProductID", primary_key: "ProductID", name: "contractproduct_ibfk_1"
  add_foreign_key "customer", "customertype", column: "CustomerTypeID", primary_key: "CustomerTypeID", name: "customer_ibfk_1"
  add_foreign_key "customer", "zone", column: "ZoneID", primary_key: "ZoneID", name: "customer_ibfk_2"
  add_foreign_key "customercontact", "customer", column: "CustomerID", primary_key: "CustomerID", name: "customercontact_ibfk_1"
  add_foreign_key "customercontact", "province", column: "Province", primary_key: "Province", name: "customercontact_ibfk_2"
  add_foreign_key "customernote", "customer", column: "CustomerID", primary_key: "CustomerID", name: "customernote_ibfk_1"
  add_foreign_key "customernote", "employee", column: "EmployeeID", primary_key: "EmployeeID", name: "customernote_ibfk_2"
  add_foreign_key "customernote", "notetype", column: "NoteTypeID", primary_key: "NoteTypeID", name: "customernote_ibfk_3"
  add_foreign_key "employee", "role", column: "RoleID", primary_key: "RoleID", name: "employee_ibfk_1"
  add_foreign_key "orderproduct", "orders", column: "OrderID", primary_key: "OrderID", name: "orderproduct_ibfk_1"
  add_foreign_key "orderproduct", "product", column: "ProductID", primary_key: "ProductID", name: "orderproduct_ibfk_2"
  add_foreign_key "orders", "customer", column: "CustomerID", primary_key: "CustomerID", name: "orders_ibfk_2"
  add_foreign_key "orders", "employee", column: "EmployeeID", primary_key: "EmployeeID", name: "orders_ibfk_1"
  add_foreign_key "product", "brand", column: "Brand", primary_key: "BrandID", name: "product_ibfk_2"
  add_foreign_key "product", "category", column: "Category", primary_key: "Category", name: "product_ibfk_1"
  add_foreign_key "route", "employee", column: "EmployeeID", primary_key: "EmployeeID", name: "route_ibfk_2"
  add_foreign_key "route", "vehicle", column: "VehicleID", primary_key: "VehicleID", name: "route_ibfk_1"
end
