import 'package:graphql_flutter/graphql_flutter.dart';

class ClienteGraphQL{
  final String url= 'https://parseapi.back4app.com/graphql';
  static HttpLink httpLinks = HttpLink(
      'https://parseapi.back4app.com/graphql',
      defaultHeaders: {
        'X-Parse-Application-Id': 'sFm15UEvDih66Avq9sRoxCQ70ur9Qaq95FZDNG5T',
        'X-Parse-Client-Key': 'gDslVEPCuWi6LfiQ20Hpi6kThkusPuTreZdBmHfT'
      }
  );

  GraphQLClient myClient(){
    return GraphQLClient(
        link: httpLinks,
        cache: GraphQLCache(),
    );
  }
}