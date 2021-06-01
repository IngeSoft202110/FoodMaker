import 'package:graphql_flutter/graphql_flutter.dart';

class ClienteGraphQL{
  final String url= 'https://parseapi.back4app.com/graphql';
  static HttpLink httpLinks = HttpLink(
      'https://parseapi.back4app.com/graphql',
      defaultHeaders: {
        'X-Parse-Application-Id':'nM1RCyRonJmydDakhBrLPQ5KMVusct3ngqG0Hi8B',
        'X-Parse-Client-Key':'nT22X3l7fDRJ1oI1UcElOCeaKnRNOSoTv44IwvFh'
      }
  );

  GraphQLClient myClient(){
    return GraphQLClient(
        link: httpLinks,
        cache: GraphQLCache(),
    );
  }
}