class OrderQueryMutation {
  String addOrder(
      double total, String orderDate, int productId, int qty, double price) {
    return """

      mutation {
        createOrder (
          total: $total
          order_date: "$orderDate"
          products: [
            {product_id: $productId,     
            qty: $qty,
            price: $price},
          ]
        )
      }
      
    """;
  }
}
