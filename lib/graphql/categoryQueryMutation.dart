class CategoryQueryMutation {
  String getCat({int first, int page}) {
    return """ 
      {
        categories (
          orderBy: [
            {
              field: "id"
              order: DESC
            }
          ], 
          first: $first, page: $page) {
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
        categories (name: "$name", orderBy: [
            {
              field: "id"
              order: DESC
            }
          ], first: $first, page: $page) {
          data {
            id
            name
          }
        }
      }
    """;
  }

  String addCat(String name) {
    return """
      mutation {
        createCat (
          name: "$name"
        ) {
          id
          name
        }
      }
    """;
  }

  String updateCat(int id, String name) {
    return """
      mutation {
        updateCat (
          id: $id
          name: "$name"
        ) {
          id
          name
        }
      }
    """;
  }

  String deleteCat(int id) {
    return """
      mutation {
        deleteCat (
          id: $id
        ) {
          id
        }
      }
    """;
  }
}
