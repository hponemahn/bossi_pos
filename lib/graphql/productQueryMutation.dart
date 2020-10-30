class ProductQueryMutation {
  String getAll({String search, int isSell, int first, int page}) {
    print("search $search");
    print("issell $isSell");
    return """ 
      {
        products (
          search: "$search",
          isSell: $isSell,
          orderBy: [
              {
                field: "id"
                order: DESC
              }
        ], first: $first, page: $page) {
          data {
            id
            name
            category_id
            stock
            buy_price
            sell_price
            discount_price
            sku
            barcode
          }
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
      int isLost,
      int isExpired,
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
          is_lost: $isLost
          is_expired: $isExpired
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
      int isLost,
      int isExpired,
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
          is_lost: $isLost
          is_expired: $isExpired
          remark: "$remark"
  ) {
    id
    name
    
  }
}
     """;
  }
}
