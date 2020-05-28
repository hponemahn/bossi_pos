
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql/utils.dart' as utils;
import '../main.dart';


HttpLink httpLink = HttpLink(
  uri: graphQLEndpoint,
);

AuthLink authLink = AuthLink(
  getToken: () => utils.getToken(),
  // getToken: () async => 'Bearer ${utils.accessToken}',
);

Link link = authLink.concat(httpLink);
GraphQLClient graphQLClient = GraphQLClient(
  cache: InMemoryCache(),
  link: link,
);