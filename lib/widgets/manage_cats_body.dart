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

    if (_searchText.isNotEmpty) {
      Provider.of<Categories>(context, listen: false)
          .fetchCats(page: _page, search: _searchText);
    } else {
      Provider.of<Categories>(context, listen: false)
          .fetchCats(page: _page, search: "");
    }
  }

  Widget _productListView(cats) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: (present <= cats.length) ? cats.length + 1 : cats.length,
          itemBuilder: (ctx, i) {
            return (i == cats.length)
                ? Container(
                    // color: Colors.greenAccent,
                    child: FlatButton(
                      child: CircularProgressIndicator(),
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

    return _cats.isEmpty
        ? Center(
            child: Text('အမျိုးအစား မရှိသေးပါ'),
          )
        : RefreshIndicator(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollState) {
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
                            _page = 1;
                            perPage = 15;
                            present = 15;
                          });

                          if (_searchText.isNotEmpty) {
                            print("search");
                            Provider.of<Categories>(context, listen: false)
                                .fetchCats(page: _page, search: _searchText);
                          } else {
                            Provider.of<Categories>(context, listen: false)
                                .fetchCats(page: _page, search: "");
                          }
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
            ),
            onRefresh: () async {
              setState(() {
                _page = 1;
                perPage = 15;
                present = 15;
                _searchText = "";
              });

              Provider.of<Categories>(context, listen: false)
                  .fetchCats(page: _page, search: "");
            },
          );
  }
}
