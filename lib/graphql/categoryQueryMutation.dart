class CategoryQueryMutation {
  String getCat({int first, int page}) {
    return """ 
      {
        categories (first: $first, page: $page) {
          data {
            id
            name
          }
        }
      }
    """;
  }

  String getCatSearch({String name, int first, int page}) {
    return """ 
      {
        categories (name: "$name", first: $first, page: $page) {
          data {
            id
            name
          }
        }
      }
    """;
  }
}
