class QueryMutation {
  String getAll() {
    return """ 
      {
        products {
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

  String addProduct(String name, int categoryId, int stock, double buyPrice, double sellPrice, double discountPrice, String sku, String barcode, int isDamaged, String remark) {
    
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

  String deletePerson(id) {
    return """
      mutation{
        deletePerson(id: "$id"){
          id
        }
      } 
    """;
  }

  String editPerson(String id, String name, String lastName, int age) {
    return """
      mutation{
          editPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
            name
            lastName
          }
      }    
     """;
  }
}
