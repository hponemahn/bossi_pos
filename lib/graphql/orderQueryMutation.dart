class OrderQueryMutation {
  String getOrderForSevenDaysData() {
    return """ 
      {
  orderForSevenDays {
    total
    order_date
  }
}
    """;
  }

  String addOrder(double total, String orderDate, List products) {
    return """
    
          mutation {
            createOrder (
              total: $total
              order_date: "$orderDate"
              products: $products
            )
          }
          
        """;
  }
}
