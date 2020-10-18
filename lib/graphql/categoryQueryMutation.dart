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
}
