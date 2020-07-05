import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;

String uuidFromObject(Object object) {
  if (object is Map<String, Object>) {
    final String typeName = object['__typename'] as String;
    final String id = object['id'] as String;
    if (typeName != null && id != null) {
      return <String>[typeName, id].join('/');
    }
  }
  return null;
}

final OptimisticCache cache = OptimisticCache(
  dataIdFromObject: uuidFromObject,
);

ValueNotifier<GraphQLClient> clientFor({
  @required String uri,
  String subscriptionUri,
}) {
  HttpLink httpLink = HttpLink(
    uri: uri,
  );

  AuthLink authLink = AuthLink(
    // getToken: () async => 'Bearer ${utils.accessToken}',
    // OR
    getToken: () => utils.getToken(),
  );

  Link link = authLink.concat(httpLink);

  // Link link = HttpLink(uri: uri);
  if (subscriptionUri != null) {
    final WebSocketLink websocketLink = WebSocketLink(
      url: subscriptionUri,
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    link = link.concat(websocketLink);
  }

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: cache,
      link: link,
    ),
  );
}

/// Wraps the root application with the `graphql_flutter` client.
/// We use the cache for all state management.
class ClientProvider extends StatelessWidget {
  ClientProvider({
    @required this.child,
    @required String uri,
    String subscriptionUri,
  }) : client = clientFor(
          uri: uri,
          subscriptionUri: subscriptionUri,
        );

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}