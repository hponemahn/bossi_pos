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

  String getLostForFiveMonthsData() {
    return """ 
      {
  lostForFiveMonths {
    total
    year
    month
  }
}
    """;
  }

  String getSaleForFourData() {
    return """ 
      {
  saleForFour {
    name
    total
    all
  }
}
    """;
  }

  String getBuyForFourData() {
    return """ 
          {
  buyForFour {
    name
    total
    all
  }
}
    """;
  }

  String getStockForFourData() {
    return """ 
          {
  stockForFour {
    name
    total
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
