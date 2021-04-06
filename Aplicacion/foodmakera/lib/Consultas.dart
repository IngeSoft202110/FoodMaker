import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'Clases/Dieta.dart';

class Consultas {
  final keyApplicationId = 'uVNLmCs5TnFunmMgMIuv2AyADHzb1OTztlkX4TDP';
  final keyClientKey = 'P1FPwQfgFN8A472OQHWdi8q9BfuMMXXIwn6zKbkF';
  final keyParseServerUrl = 'https://parseapi.back4app.com/';


   Future<List<Dieta>> buscarDiestas() async {
     await Parse().initialize(keyApplicationId, keyParseServerUrl,
         clientKey: keyClientKey, autoSendSessionId: true);

     List<Dieta> dietas= List<Dieta>();
     QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Dieta'));
     ParseResponse respuestaQuery = await query.query();

     if(respuestaQuery.success){
       for(var dieta in  respuestaQuery.results){
          Dieta nuevaDieta = Dieta.Completa(dieta.get<String>('objectId'), dieta.get<int>('id_dieta'),
              dieta.get<String>('nombre'));
           dietas.add(nuevaDieta);
       }
     }
     return dietas;
  }

}