import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/graphql/chartQuery.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Chart with ChangeNotifier {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  ChartQuery _query = ChartQuery();

  List<ChartModel> _capData = [];

  List<ChartModel> get cap => [..._capData];

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
}
