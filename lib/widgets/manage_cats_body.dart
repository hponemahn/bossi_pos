import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/widgets/manage_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCatsBody extends StatefulWidget {
  ManageCatsBody({Key key}) : super(key: key);

  @override
  _ManageCatsBodyState createState() => _ManageCatsBodyState();
}

class _ManageCatsBodyState extends State<ManageCatsBody> {
  String _searchText = "";
  int perPage = 15;
  int present = 15;
  int _page = 1;

  void loadMore() {
    setState(() {
      _page += 1;
      present = present + perPage;
    });
    Provider.of<Categories>(context, listen: false).fetchCats(_page);
  }

  Widget _productListView(cats) {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < cats.length; i++) {
        if (cats[i]
            .category
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(cats[i]);
        }
      }
      cats = tempList;
    }

    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          // itemCount: cats.length,
          itemCount: (present <= cats.length) ? cats.length + 1 : cats.length,
          itemBuilder: (ctx, i) {
            return (i == cats.length)
                ? Container(
                    // color: Colors.greenAccent,
                    child: FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: loadMore,
                      // onPressed: () => print("load"),
                    ),
                  )
                : ManageCategoryItem(cats[i].id, cats[i].category);
          }
          // Text(cats[i].category),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Category> _cats = Provider.of<Categories>(context).categories;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {

        // if (scrollState is ScrollStartNotification) {
        //           print("start");
        //         } else if (scrollState is ScrollUpdateNotification) {
        //           print("updat");
        //         } else 
                
                if (scrollState is ScrollEndNotification &&
            scrollState.metrics.pixels != 160) {
                  print("end");
                  loadMore();
                }

        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchText = val;
                  });
                },
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search),
                    hintText: 'အမည်ဖြင့် ရှာရန် ...'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _productListView(_cats),
          ],
        ),
      ),
    );
  }
}
