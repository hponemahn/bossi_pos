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

  Future<void> fetchCapData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedCapData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getCapital(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["capital"].length; i++) {
          _loadedCapData.add(
            ChartModel(
                total: result.data["capital"][i]['total'].toString(),
                day: result.data["capital"][i]['day'],
                month: result.data["capital"][i]['month'],
                year: result.data["capital"][i]['year']),
          );
        }

        _capData = _loadedCapData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchSaleData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedSaleData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getSale(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["saleChart"].length; i++) {
          _loadedSaleData.add(
            ChartModel(
                total: result.data["saleChart"][i]['total'].toString(),
                day: result.data["saleChart"][i]['day'],
                month: result.data["saleChart"][i]['month'],
                year: result.data["saleChart"][i]['year']),
          );
        }

        _saleData = _loadedSaleData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchProfitData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getProfit(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["profitChart"].length; i++) {
          _loadedProfitData.add(
            ChartModel(
                total: result.data["profitChart"][i]['total'].toString(),
                day: result.data["profitChart"][i]['day'],
                month: result.data["profitChart"][i]['month'],
                year: result.data["profitChart"][i]['year']),
          );
        }

        _profitData = _loadedProfitData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchItemProfitData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedItemProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getItemProfit(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["itemProfitChart"].length; i++) {
          _loadedItemProfitData.add(
            ChartModel(
              name: result.data["itemProfitChart"][i]['name'],
              qty: result.data["itemProfitChart"][i]['qty'],
              total: result.data["itemProfitChart"][i]['total'].toString(),
              day: result.data["itemProfitChart"][i]['day'],
              month: result.data["itemProfitChart"][i]['month'],
              year: result.data["itemProfitChart"][i]['year']),
          );
        }

        _itemProfitData = _loadedItemProfitData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchItemCatProfitData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedItemCatProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getItemCatProfit(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["itemCatProfitChart"].length; i++) {
          _loadedItemCatProfitData.add(
            ChartModel(
              name: result.data["itemCatProfitChart"][i]['name'],
              qty: result.data["itemCatProfitChart"][i]['qty'],
              total: result.data["itemCatProfitChart"][i]['total'].toString(),
              day: result.data["itemCatProfitChart"][i]['day'],
              month: result.data["itemCatProfitChart"][i]['month'],
              year: result.data["itemCatProfitChart"][i]['year']),
          );
        }

        _itemCatProfitData = _loadedItemCatProfitData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchBestSellingItemData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedBestSellingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getBestSellingItem(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["bestSellingItemChart"].length; i++) {
          _loadedBestSellingItemData.add(
            ChartModel(
              name: result.data["bestSellingItemChart"][i]['name'],
              catName: result.data["bestSellingItemChart"][i]['catName'],
              qty: result.data["bestSellingItemChart"][i]['qty'],
              total: result.data["bestSellingItemChart"][i]['total'].toString(),
              day: result.data["bestSellingItemChart"][i]['day'],
              month: result.data["bestSellingItemChart"][i]['month'],
              year: result.data["bestSellingItemChart"][i]['year']),
          );
        }

        _bestSellingItem = _loadedBestSellingItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchWorstSellingItemData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedWorstSellingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getWorstSellingItem(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["worstSellingItemChart"].length; i++) {
          _loadedWorstSellingItemData.add(
            ChartModel(
              name: result.data["worstSellingItemChart"][i]['name'],
              catName: result.data["worstSellingItemChart"][i]['catName'],
              qty: result.data["worstSellingItemChart"][i]['qty'],
              total: result.data["worstSellingItemChart"][i]['total'].toString(),
              day: result.data["worstSellingItemChart"][i]['day'],
              month: result.data["worstSellingItemChart"][i]['month'],
              year: result.data["worstSellingItemChart"][i]['year']),
          );
        }

        _worstSellingItem = _loadedWorstSellingItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchBuyData(String filter, String startDate, String endDate) async {
    try {
      final List<ChartModel> _loadedBuyData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getBuy(filter: filter, startDate: startDate, endDate: endDate)),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["buyChart"].length; i++) {
          _loadedBuyData.add(
            ChartModel(
                total: result.data["buyChart"][i]['total'].toString(),
                day: result.data["buyChart"][i]['day'],
                month: result.data["buyChart"][i]['month'],
                year: result.data["buyChart"][i]['year']),
          );
        }

        _buyData = _loadedBuyData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchMostBuyingItemData() async {
    try {
      final List<ChartModel> _loadedMostBuyingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getMostBuyingItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["mostBuyingItemChart"].length; i++) {
          _loadedMostBuyingItemData.add(
            ChartModel(
                name: result.data["mostBuyingItemChart"][i]['name'],
                qty: result.data["mostBuyingItemChart"][i]['qty'],
                total: result.data["mostBuyingItemChart"][i]['total'].toString(),
              ),
          );
        }

        _mostBuyingItemData = _loadedMostBuyingItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchMostBuyingItemCatData() async {
    try {
      final List<ChartModel> _loadedMostBuyingItemCatData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getMostBuyingItemCat()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["mostBuyingItemCatChart"].length; i++) {
          _loadedMostBuyingItemCatData.add(
            ChartModel(
                catName: result.data["mostBuyingItemCatChart"][i]['catName'],
                qty: result.data["mostBuyingItemCatChart"][i]['qty'],
                total: result.data["mostBuyingItemCatChart"][i]['total'].toString(),
              ),
          );
        }

        _mostBuyingItemCatData = _loadedMostBuyingItemCatData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchLeastBuyingItemData() async {
    try {
      final List<ChartModel> _loadedLeastBuyingItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getLeastBuyingItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["leastBuyingItemChart"].length; i++) {
          _loadedLeastBuyingItemData.add(
            ChartModel(
                name: result.data["leastBuyingItemChart"][i]['name'],
                qty: result.data["leastBuyingItemChart"][i]['qty'],
                total: result.data["leastBuyingItemChart"][i]['total'].toString(),
              ),
          );
        }

        _leastBuyingItemData = _loadedLeastBuyingItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchLeastBuyingItemCatData() async {
    try {
      final List<ChartModel> _loadedLeastBuyingItemCatData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getLeastBuyingItemCat()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["leastBuyingItemCatChart"].length; i++) {
          _loadedLeastBuyingItemCatData.add(
            ChartModel(
                catName: result.data["leastBuyingItemCatChart"][i]['catName'],
                qty: result.data["leastBuyingItemCatChart"][i]['qty'],
                total: result.data["leastBuyingItemCatChart"][i]['total'].toString(),
              ),
          );
        }

        _leastBuyingItemCatData = _loadedLeastBuyingItemCatData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchTotalItemData() async {
    try {
      final List<ChartModel> _loadedTotalItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getTotalItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["totalItemChart"].length; i++) {
          _loadedTotalItemData.add(
            ChartModel(
                name: result.data["totalItemChart"][i]['name'],
                qty: result.data["totalItemChart"][i]['qty'],
              ),
          );
        }

        _totalItemData = _loadedTotalItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchMostItemData() async {
    try {
      final List<ChartModel> _loadedMostItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getMostItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["mostItemChart"].length; i++) {
          _loadedMostItemData.add(
            ChartModel(
                name: result.data["mostItemChart"][i]['name'],
                qty: result.data["mostItemChart"][i]['qty'],
              ),
          );
        }

        _mostItemData = _loadedMostItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchLeastItemData() async {
    try {
      final List<ChartModel> _loadedLeastItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getLeastItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["leastItemChart"].length; i++) {
          _loadedLeastItemData.add(
            ChartModel(
                name: result.data["leastItemChart"][i]['name'],
                qty: result.data["leastItemChart"][i]['qty'],
              ),
          );
        }

        _leastItemData = _loadedLeastItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchDamagedItemData() async {
    try {
      final List<ChartModel> _loadedDamagedItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getDamagedItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["damagedItemChart"].length; i++) {
          _loadedDamagedItemData.add(
            ChartModel(
                name: result.data["damagedItemChart"][i]['name'],
                qty: result.data["damagedItemChart"][i]['qty'],
              ),
          );
        }

        _damagedItemData = _loadedDamagedItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchLostItemData() async {
    try {
      final List<ChartModel> _loadedLostItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getLostItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["lostItemChart"].length; i++) {
          _loadedLostItemData.add(
            ChartModel(
                name: result.data["lostItemChart"][i]['name'],
                qty: result.data["lostItemChart"][i]['qty'],
              ),
          );
        }

        _lostItemData = _loadedLostItemData;
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchExpiredItemData() async {
    try {
      final List<ChartModel> _loadedExpiredItemData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getExpiredItem()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["expiredItemChart"].length; i++) {
          _loadedExpiredItemData.add(
            ChartModel(
                name: result.data["expiredItemChart"][i]['name'],
                qty: result.data["expiredItemChart"][i]['qty'],
              ),
          );
        }

        _expiredItemData = _loadedExpiredItemData;
        notifyListeners();
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
