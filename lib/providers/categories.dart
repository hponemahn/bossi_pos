import 'package:flutter/foundation.dart';

class Category {
  final String id;
  final String category;

  Category({@required this.id, @required this.category});  
}

class Categories with ChangeNotifier {
  List<Category> _categories = [
    Category(id: "1", category: "Food"),
    Category(id: "2", category: "IT"),
    Category(id: "3", category: "Clothing"),
    Category(id: "4", category: "Accessory"),
    Category(id: "5", category: "Fashion"),
  ];

  List<Category> get categories {
    return [..._categories];
  }  

  void delete (String id) {
    _categories.removeWhere((pr) => pr.id == id);
    notifyListeners();
  }

  Category findById (String id) {
    return _categories.firstWhere((pr) => pr.id == id);
  }

  void add (Category _pr) {
    var category = Category(id: DateTime.now().toString(), category: _pr.category);
    _categories.add(category);
    notifyListeners();
  }

  void edit (Category _pr) {
    print("update id ${_pr.id}");
    int index = _categories.indexWhere((pr) => pr.id == _pr.id);
    print("update ${_pr.category}");
    if (index >= 0) {
      _categories[index] = _pr;
      notifyListeners();   
    } else {
      print("...");
    }
  }
}