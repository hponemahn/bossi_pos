import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static Link link;
  static HttpLink httpLink = HttpLink(
    uri: "http://192.168.1.5:8000/graphql",
    // headers: <String, String>{
    //   'Authorization': 'Bearer KJ7rdTbeyaptsOcZuM2Rm6EdGbHmnRkuJjJajTG8eAC8hCndavD3aXGdmC4J',
    // },
  );

  setToken(String token) {
    print("set token + $token");
    AuthLink alink = AuthLink(getToken: () async => 'Bearer ' + token);
    GraphQLConfiguration.link = alink.concat(GraphQLConfiguration.httpLink);
  }

  removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link getLink() {
    return GraphQLConfiguration.link != null
        ? GraphQLConfiguration.link
        : GraphQLConfiguration.httpLink;
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: getLink(),
    );
  }
}
