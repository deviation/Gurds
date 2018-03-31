class ProductPdf < Prawn::Document
    def initialize(products)
    super()
    @products = products

    pdf_title
    line_items
    end

    def pdf_title
        text "Products List", size: 30, style: :bold
    end

    def line_items
        move_down 20
        table line_item_rows do
            #row(0).font_style = :bold
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
        end
    end

    def line_item_rows
        [["ProductID", "Category", "Brand", "Description", "SKU", "Active"]] +
        @products.map do |product|
            [product.ProductID.to_s, product.Category.to_s, product.Brand.to_s, product.Description.to_s, product.SKU.to_s, product.Active.to_s] 
        end
    end

end
