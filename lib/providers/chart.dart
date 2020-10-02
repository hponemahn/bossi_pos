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

  List<ChartModel> get cap => [..._capData];
  List<ChartModel> get sale => [..._saleData];
  List<ChartModel> get profit => [..._profitData];
  List<ChartModel> get itemProfit => [..._itemProfitData];
  List<ChartModel> get itemCatProfit => [..._itemCatProfitData];
  List<ChartModel> get bestSellingItem => [..._bestSellingItem];
  List<ChartModel> get worstSellingItem => [..._worstSellingItem];

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
}
