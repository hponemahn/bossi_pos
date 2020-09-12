import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/graphql/chartQuery.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Chart with ChangeNotifier {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  ChartQuery _query = ChartQuery();

  List<ChartModel> _capData = [];
  List<ChartModel> _profitData = [];

  List<ChartModel> get cap => [..._capData];
  List<ChartModel> get profit => [..._profitData];

  Future<void> fetchCapData() async {
    try {
      final List<ChartModel> _loadedCapData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getCapital(filter: "m")),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["capital"].length; i++) {
          _loadedCapData.add(
            ChartModel(
                result.data["capital"][i]['total'].toString(),
                result.data["capital"][i]['day'],
                result.data["capital"][i]['month'],
                result.data["capital"][i]['year']),
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

  Future<void> fetchProfitData() async {
    try {
      final List<ChartModel> _loadedProfitData = [];

      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(_query.getProfit(filter: "m")),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["profit"].length; i++) {
          _loadedProfitData.add(
            ChartModel(
                result.data["profit"][i]['total'].toString(),
                result.data["profit"][i]['day'],
                result.data["profit"][i]['month'],
                result.data["profit"][i]['year']),
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
}
