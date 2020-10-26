import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/graphql/chartQuery.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Chart with ChangeNotifier {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  ChartQuery _query = ChartQuery();

  List<ChartModel> _capData = [];
  List<ChartModel> _saleData = [];
  List<ChartModel> _profitData = [];
  List<ChartModel> _itemProfitData = [];
  List<ChartModel> _itemCatProfitData = [];
  List<ChartModel> _bestSellingItem = [];
  List<ChartModel> _worstSellingItem = [];
  List<ChartModel> _buyData = [];
  List<ChartModel> _mostBuyingItemData = [];
  List<ChartModel> _mostBuyingItemCatData = [];
  List<ChartModel> _leastBuyingItemData = [];
  List<ChartModel> _leastBuyingItemCatData = [];
  List<ChartModel> _totalItemData = [];
  List<ChartModel> _mostItemData = [];
  List<ChartModel> _leastItemData = [];
  List<ChartModel> _damagedItemData = [];
  List<ChartModel> _lostItemData = [];
  List<ChartModel> _expiredItemData = [];

  List<ChartModel> get cap => [..._capData];
  List<ChartModel> get sale => [..._saleData];
  List<ChartModel> get profit => [..._profitData];
  List<ChartModel> get itemProfit => [..._itemProfitData];
  List<ChartModel> get itemCatProfit => [..._itemCatProfitData];
  List<ChartModel> get bestSellingItem => [..._bestSellingItem];
  List<ChartModel> get worstSellingItem => [..._worstSellingItem];
  List<ChartModel> get buy => [..._buyData];
  List<ChartModel> get mostBuyingItem => [..._mostBuyingItemData];
  List<ChartModel> get mostBuyingItemCat => [..._mostBuyingItemCatData];
  List<ChartModel> get leastBuyingItem => [..._leastBuyingItemData];
  List<ChartModel> get leastBuyingItemCat => [..._leastBuyingItemCatData];
  List<ChartModel> get totalItem => [..._totalItemData];
  List<ChartModel> get mostItem => [..._mostItemData];
  List<ChartModel> get leastItem => [..._leastItemData];
  List<ChartModel> get damagedItem => [..._damagedItemData];
  List<ChartModel> get lostItem => [..._lostItemData];
  List<ChartModel> get expiredItem => [..._expiredItemData];

  Future<void> fetchCapData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    print("fetch $page");
    try {
      final List<ChartModel> _loadedCapData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result;

      result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getCapital(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["capital"]["data"].length; i++) {
            print("load more  ${result.data["capital"]["data"][i]['month']}");
            _capData.add(
              ChartModel(
                  total: result.data["capital"]["data"][i]['total'].toString(),
                  day: result.data["capital"]["data"][i]['day'],
                  month: result.data["capital"]["data"][i]['month'],
                  year: result.data["capital"]["data"][i]['year']),
            );
            print(
                "year ${result.data["capital"]["data"][i]['year']} + month ${result.data["capital"]["data"][i]['month']}");
          }
          notifyListeners();
        } else {
          for (var i = 0; i < result.data["capital"]["data"].length; i++) {
            print("start  ${result.data["capital"]["data"][i]['month']}");
            _loadedCapData.add(
              ChartModel(
                  total: result.data["capital"]["data"][i]['total'].toString(),
                  day: result.data["capital"]["data"][i]['day'],
                  month: result.data["capital"]["data"][i]['month'],
                  year: result.data["capital"]["data"][i]['year']),
            );
          }

          _capData = [];
          _capData = _loadedCapData;
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

  Future<void> fetchSaleData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedSaleData = [];

      print("sell first $first");
      print("sell page $page");

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result;

      result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getSale(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["saleChart"]["data"].length; i++) {
            print(
                "load more sell ${result.data["saleChart"]["data"][i]['month']}");
            _saleData.add(
              ChartModel(
                  total:
                      result.data["saleChart"]["data"][i]['total'].toString(),
                  day: result.data["saleChart"]["data"][i]['day'],
                  month: result.data["saleChart"]["data"][i]['month'],
                  year: result.data["saleChart"]["data"][i]['year']),
            );
          }

          notifyListeners();
        } else {
          for (var i = 0; i < result.data["saleChart"]["data"].length; i++) {
            print(
                "first sell page  ${result.data["saleChart"]["data"][i]['month']}");
            _loadedSaleData.add(
              ChartModel(
                  total:
                      result.data["saleChart"]["data"][i]['total'].toString(),
                  day: result.data["saleChart"]["data"][i]['day'],
                  month: result.data["saleChart"]["data"][i]['month'],
                  year: result.data["saleChart"]["data"][i]['year']),
            );
          }

          _saleData = [];
          _saleData = _loadedSaleData;
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

  Future<void> fetchProfitData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getProfit(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["profitChart"]["data"].length; i++) {
            print(
                "load more profit ${result.data["profitChart"]["data"][i]['month']}");
            _profitData.add(
              ChartModel(
                  total:
                      result.data["profitChart"]["data"][i]['total'].toString(),
                  day: result.data["profitChart"]["data"][i]['day'],
                  month: result.data["profitChart"]["data"][i]['month'],
                  year: result.data["profitChart"]["data"][i]['year']),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0; i < result.data["profitChart"]["data"].length; i++) {
            print(
                "first page profit ${result.data["profitChart"]["data"][i]['month']}");
            _loadedProfitData.add(
              ChartModel(
                  total:
                      result.data["profitChart"]["data"][i]['total'].toString(),
                  day: result.data["profitChart"]["data"][i]['day'],
                  month: result.data["profitChart"]["data"][i]['month'],
                  year: result.data["profitChart"]["data"][i]['year']),
            );
          }
          _profitData = [];
          _profitData = _loadedProfitData;
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

  Future<void> fetchItemProfitData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedItemProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getItemProfit(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["itemProfitChart"]["data"].length;
              i++) {
            print(
                'load more ${result.data["itemProfitChart"]["data"][i]['day']}');
            _itemProfitData.add(
              ChartModel(
                  name: result.data["itemProfitChart"]["data"][i]['name'],
                  qty: result.data["itemProfitChart"]["data"][i]['qty'],
                  total: result.data["itemProfitChart"]["data"][i]['total']
                      .toString(),
                  day: result.data["itemProfitChart"]["data"][i]['day'],
                  month: result.data["itemProfitChart"]["data"][i]['month'],
                  year: result.data["itemProfitChart"]["data"][i]['year']),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["itemProfitChart"]["data"].length;
              i++) {
            print('start ${result.data["itemProfitChart"]["data"][i]['day']}');
            _loadedItemProfitData.add(
              ChartModel(
                  name: result.data["itemProfitChart"]["data"][i]['name'],
                  qty: result.data["itemProfitChart"]["data"][i]['qty'],
                  total: result.data["itemProfitChart"]["data"][i]['total']
                      .toString(),
                  day: result.data["itemProfitChart"]["data"][i]['day'],
                  month: result.data["itemProfitChart"]["data"][i]['month'],
                  year: result.data["itemProfitChart"]["data"][i]['year']),
            );
          }
          _itemProfitData = [];
          _itemProfitData = _loadedItemProfitData;
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

  Future<void> fetchItemCatProfitData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedItemCatProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getItemCatProfit(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["itemCatProfitChart"]["data"].length;
              i++) {
            _itemCatProfitData.add(
              ChartModel(
                  name: result.data["itemCatProfitChart"]["data"][i]['name'],
                  qty: result.data["itemCatProfitChart"]["data"][i]['qty'],
                  total: result.data["itemCatProfitChart"]["data"][i]['total']
                      .toString(),
                  day: result.data["itemCatProfitChart"]["data"][i]['day'],
                  month: result.data["itemCatProfitChart"]["data"][i]['month'],
                  year: result.data["itemCatProfitChart"]["data"][i]['year']),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["itemCatProfitChart"]["data"].length;
              i++) {
            _loadedItemCatProfitData.add(
              ChartModel(
                  name: result.data["itemCatProfitChart"]["data"][i]['name'],
                  qty: result.data["itemCatProfitChart"]["data"][i]['qty'],
                  total: result.data["itemCatProfitChart"]["data"][i]['total']
                      .toString(),
                  day: result.data["itemCatProfitChart"]["data"][i]['day'],
                  month: result.data["itemCatProfitChart"]["data"][i]['month'],
                  year: result.data["itemCatProfitChart"]["data"][i]['year']),
            );
          }
          _itemCatProfitData = [];
          _itemCatProfitData = _loadedItemCatProfitData;
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

  Future<void> fetchBestSellingItemData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedBestSellingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getBestSellingItem(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["bestSellingItemChart"]["data"].length;
              i++) {
            _bestSellingItem.add(
              ChartModel(
                  name: result.data["bestSellingItemChart"]["data"][i]['name'],
                  catName: result.data["bestSellingItemChart"]["data"][i]
                      ['catName'],
                  qty: result.data["bestSellingItemChart"]["data"][i]['qty'],
                  total: result.data["bestSellingItemChart"]["data"][i]['total']
                      .toString(),
                  day: result.data["bestSellingItemChart"]["data"][i]['day'],
                  month: result.data["bestSellingItemChart"]["data"][i]
                      ['month'],
                  year: result.data["bestSellingItemChart"]["data"][i]['year']),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["bestSellingItemChart"]["data"].length;
              i++) {
            _loadedBestSellingItemData.add(
              ChartModel(
                  name: result.data["bestSellingItemChart"]["data"][i]['name'],
                  catName: result.data["bestSellingItemChart"]["data"][i]
                      ['catName'],
                  qty: result.data["bestSellingItemChart"]["data"][i]['qty'],
                  total: result.data["bestSellingItemChart"]["data"][i]['total']
                      .toString(),
                  day: result.data["bestSellingItemChart"]["data"][i]['day'],
                  month: result.data["bestSellingItemChart"]["data"][i]
                      ['month'],
                  year: result.data["bestSellingItemChart"]["data"][i]['year']),
            );
          }
          _bestSellingItem = [];
          _bestSellingItem = _loadedBestSellingItemData;
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

  Future<void> fetchWorstSellingItemData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedWorstSellingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getWorstSellingItem(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["worstSellingItemChart"]["data"].length;
              i++) {
            _worstSellingItem.add(
              ChartModel(
                  name: result.data["worstSellingItemChart"]["data"][i]['name'],
                  catName: result.data["worstSellingItemChart"]["data"][i]
                      ['catName'],
                  qty: result.data["worstSellingItemChart"]["data"][i]['qty'],
                  total: result.data["worstSellingItemChart"]["data"][i]
                          ['total']
                      .toString(),
                  day: result.data["worstSellingItemChart"]["data"][i]['day'],
                  month: result.data["worstSellingItemChart"]["data"][i]
                      ['month'],
                  year: result.data["worstSellingItemChart"]["data"][i]
                      ['year']),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["worstSellingItemChart"]["data"].length;
              i++) {
            _loadedWorstSellingItemData.add(
              ChartModel(
                  name: result.data["worstSellingItemChart"]["data"][i]['name'],
                  catName: result.data["worstSellingItemChart"]["data"][i]
                      ['catName'],
                  qty: result.data["worstSellingItemChart"]["data"][i]['qty'],
                  total: result.data["worstSellingItemChart"]["data"][i]
                          ['total']
                      .toString(),
                  day: result.data["worstSellingItemChart"]["data"][i]['day'],
                  month: result.data["worstSellingItemChart"]["data"][i]
                      ['month'],
                  year: result.data["worstSellingItemChart"]["data"][i]
                      ['year']),
            );
          }
          _worstSellingItem = [];
          _worstSellingItem = _loadedWorstSellingItemData;
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

  Future<void> fetchBuyData(
      {String filter,
      String startDate,
      String endDate,
      int first,
      int page}) async {
    try {
      final List<ChartModel> _loadedBuyData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getBuy(
              filter: filter,
              startDate: startDate,
              endDate: endDate,
              first: first,
              page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["buyChart"]["data"].length; i++) {
            _buyData.add(
              ChartModel(
                  total: result.data["buyChart"]["data"][i]['total'].toString(),
                  day: result.data["buyChart"]["data"][i]['day'],
                  month: result.data["buyChart"]["data"][i]['month'],
                  year: result.data["buyChart"]["data"][i]['year']),
            );
          }

          notifyListeners();
        } else {
          for (var i = 0; i < result.data["buyChart"]["data"].length; i++) {
            _loadedBuyData.add(
              ChartModel(
                  total: result.data["buyChart"]["data"][i]['total'].toString(),
                  day: result.data["buyChart"]["data"][i]['day'],
                  month: result.data["buyChart"]["data"][i]['month'],
                  year: result.data["buyChart"]["data"][i]['year']),
            );
          }

          _buyData = [];
          _buyData = _loadedBuyData;
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

  Future<void> fetchMostBuyingItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedMostBuyingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getMostBuyingItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["mostBuyingItemChart"]["data"].length;
              i++) {
            _mostBuyingItemData.add(
              ChartModel(
                name: result.data["mostBuyingItemChart"]["data"][i]['name'],
                qty: result.data["mostBuyingItemChart"]["data"][i]['qty'],
                total: result.data["mostBuyingItemChart"]["data"][i]['total']
                    .toString(),
              ),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["mostBuyingItemChart"]["data"].length;
              i++) {
            _loadedMostBuyingItemData.add(
              ChartModel(
                name: result.data["mostBuyingItemChart"]["data"][i]['name'],
                qty: result.data["mostBuyingItemChart"]["data"][i]['qty'],
                total: result.data["mostBuyingItemChart"]["data"][i]['total']
                    .toString(),
              ),
            );
          }
          _mostBuyingItemData = [];
          _mostBuyingItemData = _loadedMostBuyingItemData;
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

  Future<void> fetchMostBuyingItemCatData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedMostBuyingItemCatData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode:
              gql(_query.getMostBuyingItemCat(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["mostBuyingItemCatChart"]["data"].length;
              i++) {
            _mostBuyingItemCatData.add(
              ChartModel(
                catName: result.data["mostBuyingItemCatChart"]["data"][i]
                    ['catName'],
                qty: result.data["mostBuyingItemCatChart"]["data"][i]['qty'],
                total: result.data["mostBuyingItemCatChart"]["data"][i]['total']
                    .toString(),
              ),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["mostBuyingItemCatChart"]["data"].length;
              i++) {
            _loadedMostBuyingItemCatData.add(
              ChartModel(
                catName: result.data["mostBuyingItemCatChart"]["data"][i]
                    ['catName'],
                qty: result.data["mostBuyingItemCatChart"]["data"][i]['qty'],
                total: result.data["mostBuyingItemCatChart"]["data"][i]['total']
                    .toString(),
              ),
            );
          }
          _mostBuyingItemCatData = [];
          _mostBuyingItemCatData = _loadedMostBuyingItemCatData;
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

  Future<void> fetchLeastBuyingItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedLeastBuyingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode:
              gql(_query.getLeastBuyingItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["leastBuyingItemChart"]["data"].length;
              i++) {
            _leastBuyingItemData.add(
              ChartModel(
                name: result.data["leastBuyingItemChart"]["data"][i]['name'],
                qty: result.data["leastBuyingItemChart"]["data"][i]['qty'],
                total: result.data["leastBuyingItemChart"]["data"][i]['total']
                    .toString(),
              ),
            );
          }
          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["leastBuyingItemChart"]["data"].length;
              i++) {
            _loadedLeastBuyingItemData.add(
              ChartModel(
                name: result.data["leastBuyingItemChart"]["data"][i]['name'],
                qty: result.data["leastBuyingItemChart"]["data"][i]['qty'],
                total: result.data["leastBuyingItemChart"]["data"][i]['total']
                    .toString(),
              ),
            );
          }
          _leastBuyingItemData = [];
          _leastBuyingItemData = _loadedLeastBuyingItemData;
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

  Future<void> fetchLeastBuyingItemCatData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedLeastBuyingItemCatData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode:
              gql(_query.getLeastBuyingItemCat(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0;
              i < result.data["leastBuyingItemCatChart"]["data"].length;
              i++) {
            _leastBuyingItemCatData.add(
              ChartModel(
                catName: result.data["leastBuyingItemCatChart"]["data"][i]
                    ['catName'],
                qty: result.data["leastBuyingItemCatChart"]["data"][i]['qty'],
                total: result.data["leastBuyingItemCatChart"]["data"][i]
                        ['total']
                    .toString(),
              ),
            );
          }

          notifyListeners();
        } else {
          for (var i = 0;
              i < result.data["leastBuyingItemCatChart"]["data"].length;
              i++) {
            _loadedLeastBuyingItemCatData.add(
              ChartModel(
                catName: result.data["leastBuyingItemCatChart"]["data"][i]
                    ['catName'],
                qty: result.data["leastBuyingItemCatChart"]["data"][i]['qty'],
                total: result.data["leastBuyingItemCatChart"]["data"][i]
                        ['total']
                    .toString(),
              ),
            );
          }

          _leastBuyingItemCatData = [];
          _leastBuyingItemCatData = _loadedLeastBuyingItemCatData;
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

  Future<void> fetchTotalItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedTotalItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getTotalItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["totalItemChart"]["data"].length; i++) {
          _totalItemData.add(
            ChartModel(
              name: result.data["totalItemChart"]["data"][i]['name'],
              qty: result.data["totalItemChart"]["data"][i]['qty'],
            ),
          );
        }
        notifyListeners();
        } else {
          for (var i = 0; i < result.data["totalItemChart"]["data"].length; i++) {
          _loadedTotalItemData.add(
            ChartModel(
              name: result.data["totalItemChart"]["data"][i]['name'],
              qty: result.data["totalItemChart"]["data"][i]['qty'],
            ),
          );
        }
        _totalItemData = [];
        _totalItemData = _loadedTotalItemData;
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

  Future<void> fetchMostItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedMostItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getMostItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["mostItemChart"]["data"].length; i++) {
          _mostItemData.add(
            ChartModel(
              name: result.data["mostItemChart"]["data"][i]['name'],
              qty: result.data["mostItemChart"]["data"][i]['qty'],
            ),
          );
        }
        notifyListeners();
        } else {
          for (var i = 0; i < result.data["mostItemChart"]["data"].length; i++) {
          _loadedMostItemData.add(
            ChartModel(
              name: result.data["mostItemChart"]["data"][i]['name'],
              qty: result.data["mostItemChart"]["data"][i]['qty'],
            ),
          );
        }
        _mostItemData = [];
        _mostItemData = _loadedMostItemData;
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

  Future<void> fetchLeastItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedLeastItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getLeastItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["leastItemChart"]["data"].length; i++) {
          _leastItemData.add(
            ChartModel(
              name: result.data["leastItemChart"]["data"][i]['name'],
              qty: result.data["leastItemChart"]["data"][i]['qty'],
            ),
          );
        }
        notifyListeners();
        } else {
          for (var i = 0; i < result.data["leastItemChart"]["data"].length; i++) {
          _loadedLeastItemData.add(
            ChartModel(
              name: result.data["leastItemChart"]["data"][i]['name'],
              qty: result.data["leastItemChart"]["data"][i]['qty'],
            ),
          );
        }
        _leastItemData = [];
        _leastItemData = _loadedLeastItemData;
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

  Future<void> fetchDamagedItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedDamagedItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getDamagedItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["damagedItemChart"]["data"].length; i++) {
          _damagedItemData.add(
            ChartModel(
              name: result.data["damagedItemChart"]["data"][i]['name'],
              qty: result.data["damagedItemChart"]["data"][i]['qty'],
            ),
          );
        }
        notifyListeners();
        } else {
          for (var i = 0; i < result.data["damagedItemChart"]["data"].length; i++) {
          _loadedDamagedItemData.add(
            ChartModel(
              name: result.data["damagedItemChart"]["data"][i]['name'],
              qty: result.data["damagedItemChart"]["data"][i]['qty'],
            ),
          );
        }
        _damagedItemData = [];
        _damagedItemData = _loadedDamagedItemData;
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

  Future<void> fetchLostItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedLostItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getLostItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["lostItemChart"]["data"].length; i++) {
          _lostItemData.add(
            ChartModel(
              name: result.data["lostItemChart"]["data"][i]['name'],
              qty: result.data["lostItemChart"]["data"][i]['qty'],
            ),
          );
        }
        notifyListeners();
        } else {
          for (var i = 0; i < result.data["lostItemChart"]["data"].length; i++) {
          _loadedLostItemData.add(
            ChartModel(
              name: result.data["lostItemChart"]["data"][i]['name'],
              qty: result.data["lostItemChart"]["data"][i]['qty'],
            ),
          );
        }
        _lostItemData = [];
        _lostItemData = _loadedLostItemData;
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

  Future<void> fetchExpiredItemData({int first, int page}) async {
    try {
      final List<ChartModel> _loadedExpiredItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getExpiredItem(first: first, page: page)),
        ),
      );

      if (!result.hasException) {
        if (page > 1) {
          for (var i = 0; i < result.data["expiredItemChart"]["data"].length; i++) {
          _expiredItemData.add(
            ChartModel(
              name: result.data["expiredItemChart"]["data"][i]['name'],
              qty: result.data["expiredItemChart"]["data"][i]['qty'],
            ),
          );
        }

        notifyListeners();
        } else {
          for (var i = 0; i < result.data["expiredItemChart"]["data"].length; i++) {
          _loadedExpiredItemData.add(
            ChartModel(
              name: result.data["expiredItemChart"]["data"][i]['name'],
              qty: result.data["expiredItemChart"]["data"][i]['qty'],
            ),
          );
        }

        _expiredItemData = [];
        _expiredItemData = _loadedExpiredItemData;
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
