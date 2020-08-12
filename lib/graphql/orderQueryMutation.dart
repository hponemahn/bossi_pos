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

  String getNetForFiveMonthsData() {
    return """ 
      {
  netForFiveMonths {
    total
    year
    month
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
