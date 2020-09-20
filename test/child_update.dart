import 'package:http/http.dart' show Client;
import 'dart:io';
import 'dart:convert';
import 'package:drops/utils/data_endpoints_config.dart';
import 'package:drops/entities/child.dart';
import 'package:http/src/response.dart';

void main() {
  final client = Client();
  final pda = 'terryleehcfdev.hubat.net';
  final recordId = 'd8c67138-b455-40cc-8966-0e5434571ffe';
  Response response;

  String input = stdin.readLineSync();

  new File('token.txt').readAsString().then((token) async {
    dynamic body =[{
      'recordId': recordId,
      'endpoint': childrenEndpoint,
      'data': {
        'name': input,
        'relationship': 'child'
      }
    }];
    response = await client.put('https://$pda/$dataEndpointUrl', body: jsonEncode(body), headers: { 'Content-Type': 'application/json', 'X-Auth-Token': token});
    if (response.statusCode == 201) {
      Iterable body = json.decode(response.body);
      if (body.length==0) throw Exception("Child Not Saved.");
      Child profile = Child.fromJson(body.first);
      print(profile);
    } else {
      throw Exception("Failed to save Child.");
    }
  }).catchError((error) => print(error));
}