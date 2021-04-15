import 'package:graphql_flutter/graphql_flutter.dart';

class ClienteGraphQL{
  final String url= 'https://parseapi.back4app.com/graphql';
  static HttpLink httpLinks = HttpLink(
      'https://parseapi.back4app.com/graphql',
      defaultHeaders: {
        'X-Parse-Application-Id': 'yFiP4Tazg0vBRr2wZl2ul19YKlQssmXGUCiCqETQ',
        'X-Parse-Client-Key': '4h9CdlwsBuDQOl8L9ImOvD66jAdSaJtxcvzTcaIw'
      }
  );

  GraphQLClient myClient(){
    return GraphQLClient(
        link: httpLinks,
        cache: GraphQLCache(),
    );
  }
}