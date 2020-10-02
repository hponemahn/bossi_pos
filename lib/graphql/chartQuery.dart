class ChartQuery {
  String getCapital({String filter, String startDate, String endDate}) {
    return """
      {
  capital(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
    total
    day
    year
    month
    months
  }
}
    """;
  }

  String getSale({String filter, String startDate, String endDate}) {
    return """
      {
  saleChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
    total
    day
    year
    month
    months
  }
}
    """;
  }

  String getProfit({String filter, String startDate, String endDate}) {
    return """
      {
  profitChart(filter: "$filter", startDate: "$startDate", endDate: "$endDate") {   
    total
    day
    year
    month
    months
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

  String getWorstSellingItem({String filter, String startDate, String endDate}) {
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
}
