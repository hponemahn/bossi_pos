import 'package:flutter/foundation.dart';

class Category {
  final int id;
  final String category;

  Category({@required this.id, @required this.category});  
}

class Categories with ChangeNotifier {
  List<Category> _categories = [
    Category(id: 1, category: "Food"),
    Category(id: 2, category: "IT"),
    Category(id: 3, category: "Clothing"),
    Category(id: 4, category: "Accessory"),
    Category(id: 5, category: "Fashion"),
  ];

  List<Category> get categories {
    return [..._categories];
  }  
}