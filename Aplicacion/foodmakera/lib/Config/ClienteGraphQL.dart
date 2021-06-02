import 'package:graphql_flutter/graphql_flutter.dart';

class ClienteGraphQL{
  final String url= 'https://parseapi.back4app.com/graphql';
  static HttpLink httpLinks = HttpLink(
      'https://parseapi.back4app.com/graphql',
      defaultHeaders: {
        'X-Parse-Application-Id':'SqsZrzHA1Gz5KlOn8AafLjwrYbpkyhi0HP1B3OEv',
        'X-Parse-Client-Key':'DcvAZ78PVx8PP3QXRgFMBBAus6NMN2YD4ad3nLeS'
      }
  );

  GraphQLClient myClient(){
    return GraphQLClient(
        link: httpLinks,
        cache: GraphQLCache(),
    );
  }
}