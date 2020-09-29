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
}
