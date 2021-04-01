import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


void main() async {
  final keyApplicationId = 'uVNLmCs5TnFunmMgMIuv2AyADHzb1OTztlkX4TDP';
  final keyClientKey = 'P1FPwQfgFN8A472OQHWdi8q9BfuMMXXIwn6zKbkF';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  var firstObject = ParseObject('Prueba')
    ..set('Nombre', 'Fulanito de tal')
    ..set('NDocumento', 1000);
  await firstObject.save();
}
