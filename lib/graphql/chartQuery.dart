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
}
