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

  String getSale({String filter}) {
    return """
      {
  saleChart(filter: "$filter") {   
    total
    day
    year
    month
    months
  }
}
    """;
  }

  String getProfit({String filter}) {
    return """
      {
  profitChart(filter: "$filter") {   
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
