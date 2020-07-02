class ProductQueryMutation {
  String getAll() {
    return """ 
      {
        products (orderBy: [
        {
          field: "id"
          order: DESC
        }
    ]) {
          id
          name
          stock
          buy_price
          sell_price
          discount_price
          sku
          barcode
          is_damaged
          remark
        }
      }
    """;
  }

  String addProduct(
      String name,
      int categoryId,
      int stock,
      double buyPrice,
      double sellPrice,
      double discountPrice,
      String sku,
      String barcode,
      int isDamaged,
      String remark) {
    return """
      mutation {
        createProduct (     
          name: "$name"
          category_id: $categoryId
          stock: $stock
          buy_price: $buyPrice
          sell_price: $sellPrice
          discount_price: $discountPrice
          sku: "$sku"
          barcode: "$barcode"
          is_damaged: $isDamaged
          remark: "$remark"
        ) {
          id
          name
        }
      }
    """;
  }

  String deleteProduct(String id) {
    return """
      mutation {
        deleteProduct (
              id: $id
        ) {
          id
        }
      }
    """;
  }

  String editProduct(
      String id,
      String name,
      int categoryId,
      int stock,
      double buyPrice,
      double sellPrice,
      double discountPrice,
      String sku,
      String barcode,
      int isDamaged,
      String remark) {
    return """
      mutation {
        updateProduct (     
          id: $id
          name: "$name"
          category_id: $categoryId
          stock: $stock
          buy_price: $buyPrice
          sell_price: $sellPrice
          discount_price: $discountPrice
          sku: "$sku"
          barcode: "$barcode"
          is_damaged: $isDamaged
          remark: "$remark"
  ) {
    id
    name
    
  }
}
     """;
  }
}
