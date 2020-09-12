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

  String getProfit({String filter}) {
    return """
      {
  profit(filter: "$filter") {   
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
