import 'package:graphql_flutter/graphql_flutter.dart';

class ClienteGraphQL{
  final String url= 'https://parseapi.back4app.com/graphql';
  static HttpLink httpLinks = HttpLink(
      'https://parseapi.back4app.com/graphql',
      defaultHeaders: {
        'X-Parse-Application-Id': 'yC5PSjDttvVvIkpBOWaHUZYo6lIHxQFKxwFD6ydT',
        'X-Parse-Client-Key': 'TI3txrhBGDTlkHNtpyfdODfhoNLDcJF2wdKGfPY7'
      }
  );

  GraphQLClient myClient(){
    return GraphQLClient(
        link: httpLinks,
        cache: GraphQLCache(),
    );
  }
}