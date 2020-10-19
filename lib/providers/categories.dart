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

    _deleteGraphQL(id);
  }

  Future<void> _deleteGraphQL(String id) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(addMutation.deleteCat(int.parse(id))),
      ),
    );

    print(result.exception);
  }

  Category findById(String id) {
    return _categories.firstWhere((pr) => pr.id == id);
  }

  void add(Category _cat) async {
    String _id = await _addGraphQL(_cat.category);
    var category = Category(id: _id, category: _cat.category);
    _categories.insert(0, category);
    notifyListeners();
  }

  Future<String> _addGraphQL(String _cat) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(addMutation.addCat(
            _cat,
          )),
        ),
      );

      print(result.exception);
      return result.data['createCat']['id'];
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<String> addAndGetID(Category _cat) async {
    
    String _id = await _addGraphQL(_cat.category);
    var category = Category(id: _id, category: _cat.category);
    _categories.insert(0, category);
    notifyListeners();

    return _id;
  }

  void edit(Category _cat) {
    int index = _categories.indexWhere((pr) => pr.id == _cat.id);
    if (index >= 0) {
      _categories[index] = _cat;
      notifyListeners();

      _updateGraphQL(_cat);
    } else {
      print("...");
    }
  }

  Future<void> _updateGraphQL(Category _cat) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(addMutation.updateCat(
            int.parse(_cat.id),
            _cat.category,
          )),
        ),
      );

      print(result.exception);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchCats({int page, String search}) async {
    try {
      final List<Category> loadedCats = [];

      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result;

      if (search.isEmpty) {
        result = await _client.query(
          QueryOptions(
            documentNode: gql(addMutation.getCat(first: 15, page: page)),
          ),
        );
      } else {
        print("fetch with search");
        result = await _client.query(
          QueryOptions(
            documentNode: gql(
                addMutation.getCatSearch(name: search, first: 15, page: page)),
          ),
        );
      }

      if (!result.hasException) {
        print('no exception');

        if (page > 1) {
          for (var i = 0; i < result.data["categories"]["data"].length; i++) {
            _categories.add(Category(
              id: result.data["categories"]['data'][i]['id'],
              category: result.data["categories"]['data'][i]['name'],
            ));

            print("fetch load more");
            print(result.data["categories"]['data'][i]['id']);

            // _categories = loadedCats;
            notifyListeners();
          }
        } else {
          for (var i = 0; i < result.data["categories"]["data"].length; i++) {
            loadedCats.add(Category(
              id: result.data["categories"]['data'][i]['id'],
              category: result.data["categories"]['data'][i]['name'],
            ));

            print("fetch");
            print(result.data["categories"]['data'][i]['id']);

            _categories = [];
            _categories = loadedCats;
            notifyListeners();
          }
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

  Future<void> fetchAllCat() async {
    try {
      final List<Category> loadedAllCat = [];

      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(addMutation.getAllCat()),
          // document: queryMutation.getAll(),
        ),
      );

      if (!result.hasException) {
        print('no exception');

        for (var i = 0; i < result.data["allCat"].length; i++) {

          loadedAllCat.add(
            Category(
              id: result.data["allCat"][i]['id'],
              category: result.data["allCat"][i]['name'],
            )
            );

          _categories = loadedAllCat;
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
