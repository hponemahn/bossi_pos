import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:bossi_pos/auths/utils.dart' as utils;

final HttpLink httpLink = HttpLink(
    uri: 'http://192.168.100.25:8000/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => utils.getToken(),
  );

  final Link link = authLink.concat(httpLink);

class GraphQLConfiguration {
  // static HttpLink httpLink = HttpLink(
  //   uri: "http://192.168.43.252:8000/graphql",
  // );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      // link: httpLink,
      link: link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}
