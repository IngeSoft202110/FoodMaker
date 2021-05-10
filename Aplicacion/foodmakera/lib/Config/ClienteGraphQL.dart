import 'package:graphql_flutter/graphql_flutter.dart';

class ClienteGraphQL{
  final String url= 'https://parseapi.back4app.com/graphql';
  static HttpLink httpLinks = HttpLink(
      'https://parseapi.back4app.com/graphql',
      defaultHeaders: {
        'X-Parse-Application-Id':'QkiDaibHBqiqgEVFZnGbfHjBqsAHczeJvCeRSAOu',
        'X-Parse-Client-Key':'2dMSqnGMfojqLYwslmfIL2f1DU80xrbdyCLvOx5H'
      }
  );

  GraphQLClient myClient(){
    return GraphQLClient(
        link: httpLinks,
        cache: GraphQLCache(),
    );
  }
}