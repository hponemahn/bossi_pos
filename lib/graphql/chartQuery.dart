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

  String getItemProfit(
      {String filter, String startDate, String endDate, int first, int page}) {
    return """
      {
        itemProfitChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
          data {
            name
            qty
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

  String getItemCatProfit(
      {String filter, String startDate, String endDate, int first, int page}) {
    return """
      {
        itemCatProfitChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
          data {
            name
            qty
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

  String getBestSellingItem(
      {String filter, String startDate, String endDate, int first, int page}) {
    return """
      {
        bestSellingItemChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
          data {
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
      }
          """;
  }

  String getWorstSellingItem(
      {String filter, String startDate, String endDate, int first, int page}) {
    return """
      {
        worstSellingItemChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
          data {
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
      }
          """;
  }

  String getBuy(
      {String filter, String startDate, String endDate, int first, int page}) {
    return """
      {
  buyChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate", first: $first, page: $page) {   
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

  String getMostBuyingItem({int first, int page}) {
    return """
        {
          mostBuyingItemChart (first: $first, page: $page) { 
            data {
              name
              qty
              total
            }
          }
        }
    """;
  }

  String getMostBuyingItemCat({int first, int page}) {
    return """
        {
          mostBuyingItemCatChart (first: $first, page: $page) { 
            data {
              catName
              qty
              total
            }
          }
        }
    """;
  }

  String getLeastBuyingItem({int first, int page}) {
    return """
        {
          leastBuyingItemChart (first: $first, page: $page) { 
            data {
              name
              qty
              total
            }
          }
        }
    """;
  }

  String getLeastBuyingItemCat({int first, int page}) {
    return """
        {
          leastBuyingItemCatChart (first: $first, page: $page) { 
            data {
              catName
              qty
              total
            }
          }
        }
    """;
  }

  String getTotalItem({int first, int page}) {
    return """
        {
          totalItemChart (first: $first, page: $page) { 
            data {
              name
              qty
            }
          }
        }
    """;
  }

  String getMostItem({int first, int page}) {
    return """
        {
          mostItemChart (first: $first, page: $page) { 
            data {
              name
              qty
            }
          }
        }
    """;
  }

  String getLeastItem({int first, int page}) {
    return """
        {
          leastItemChart (first: $first, page: $page) { 
            data {
              name
              qty
            }
          }
        }
    """;
  }

  String getDamagedItem({int first, int page}) {
    return """
        {
          damagedItemChart (first: $first, page: $page) { 
            data {
              name
              qty
            }
          }
        }
    """;
  }

  String getLostItem({int first, int page}) {
    return """
        {
          lostItemChart (first: $first, page: $page) { 
            data {
              name
              qty
            }
          }
        }
    """;
  }

  String getExpiredItem({int first, int page}) {
    return """
        {
          expiredItemChart (first: $first, page: $page) { 
            data {
              name
              qty
            }
          }
        }
    """;
  }
}
