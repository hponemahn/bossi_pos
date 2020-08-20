import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import '../graphql/utils.dart' as utils;

final HttpLink httpLink = HttpLink(
  uri: 'http://172.10.0.195:8000/graphql',
);

final AuthLink authLink = AuthLink(
  getToken: () async => utils.getToken(),
);

final Link link = authLink.concat(httpLink);

class GraphQLConfiguration {
  // static HttpLink httpLink = HttpLink(
  //   uri: "http://172.10.0.195:8000/graphql",
  // );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      // cache: InMemoryCache()
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      // link: httpLink,
      link: link,
    );
  }
}
