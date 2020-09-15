class ChartQuery {
  String getCapital({String filter}) {
    return """
      {
  capital(filter: "$filter") {   
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
