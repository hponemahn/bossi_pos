class ChartQuery {
  String getCapital(
      {String filter, String startDate, String endDate, int first, int page}) {
    print("query $page");
    return """
      {
  capital(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
    data {
      total
      day
      year
      month
      months
    }
  }
}
    """;
  }

  String getSale(
      {String filter, String startDate, String endDate, int first, int page}) {
        print("get sale graphQL page $page");
    return """
      {
  saleChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
    data {
      total
      day
      year
      month
      months
    }
  }
}
    """;
  }

  String getProfit(
      {String filter, String startDate, String endDate, int first, int page}) {
    return """
      {
  profitChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
    data {
      total
      day
      year
      month
      months
    }
  }
}
    """;
  }

  String getItemProfit({String filter, String startDate, String endDate}) {
    return """
      {
        itemProfitChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
          name
          qty
          total
          day
          year
          month
          months
        }
      }
          """;
  }

  String getItemCatProfit({String filter, String startDate, String endDate}) {
    return """
      {
        itemCatProfitChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
          name
          qty
          total
          day
          year
          month
          months
        }
      }
          """;
  }

  String getBestSellingItem({String filter, String startDate, String endDate}) {
    return """
      {
        bestSellingItemChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
          name
          catName
          qty
          total
          day
          year
          month
          months
        }
      }
          """;
  }

  String getWorstSellingItem(
      {String filter, String startDate, String endDate}) {
    return """
      {
        worstSellingItemChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
          name
          catName
          qty
          total
          day
          year
          month
          months
        }
      }
          """;
  }

  String getBuy({String filter, String startDate, String endDate}) {
    return """
      {
  buyChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
    total
    day
    year
    month
    months
  }
}
    """;
  }

  String getMostBuyingItem() {
    return """
        {
          mostBuyingItemChart { 
            name
            qty
            total
          }
        }
    """;
  }

  String getMostBuyingItemCat() {
    return """
        {
          mostBuyingItemCatChart { 
            catName
            qty
            total
          }
        }
    """;
  }

  String getLeastBuyingItem() {
    return """
        {
          leastBuyingItemChart { 
            name
            qty
            total
          }
        }
    """;
  }

  String getLeastBuyingItemCat() {
    return """
        {
          leastBuyingItemCatChart { 
            catName
            qty
            total
          }
        }
    """;
  }

  String getTotalItem() {
    return """
        {
          totalItemChart { 
            name
            qty
          }
        }
    """;
  }

  String getMostItem() {
    return """
        {
          mostItemChart { 
            name
            qty
          }
        }
    """;
  }

  String getLeastItem() {
    return """
        {
          leastItemChart { 
            name
            qty
          }
        }
    """;
  }

  String getDamagedItem() {
    return """
        {
          damagedItemChart { 
            name
            qty
          }
        }
    """;
  }

  String getLostItem() {
    return """
        {
          lostItemChart { 
            name
            qty
          }
        }
    """;
  }

  String getExpiredItem() {
    return """
        {
          expiredItemChart { 
            name
            qty
          }
        }
    """;
  }
}
