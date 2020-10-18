import 'package:bossi_pos/graphql/categoryQueryMutation.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Category {
  final String id;
  final String category;

  Category({@required this.id, @required this.category});
}

class Categories with ChangeNotifier {
  
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  CategoryQueryMutation addMutation = CategoryQueryMutation();

  List<Category> _categories = [
    // Category(id: "1", category: "Food"),
    // Category(id: "2", category: "IT"),
    // Category(id: "3", category: "Clothing"),
    // Category(id: "4", category: "Accessory"),
    // Category(id: "5", category: "Fashion"),
  ];

  List<Category> get categories {
    return [..._categories];
  }

  void delete(String id) {
    _categories.removeWhere((pr) => pr.id == id);
    notifyListeners();
  }

  Category findById(String id) {
    return _categories.firstWhere((pr) => pr.id == id);
  }

  void add(Category _pr) {
    var category =
        Category(id: DateTime.now().toString(), category: _pr.category);
    _categories.add(category);
    notifyListeners();
  }

  String addAndGetID(Category _pr) {
    var category =
        Category(id: DateTime.now().toString(), category: _pr.category);
    _categories.add(category);
    notifyListeners();
    return category.id;
  }

  void edit(Category _pr) {
    int index = _categories.indexWhere((pr) => pr.id == _pr.id);
    if (index >= 0) {
      _categories[index] = _pr;
      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> fetchCats([int page]) async {
    try {
      final List<Category> loadedCats = [];

      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(addMutation.getCat(first: 15, page: page)),
        ),
      );

      if (!result.hasException) {
        print('no exception');

        for (var i = 0; i < result.data["categories"]["data"].length; i++) {

          loadedCats.add(
            Category(
              id: result.data["categories"]['data'][i]['id'],
              category: result.data["categories"]['data'][i]['name'],
            )
          );

          print("fetch");
          print(result.data["categories"]['data'][i]['id']);

          _categories = loadedCats;
          notifyListeners();
        }
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
