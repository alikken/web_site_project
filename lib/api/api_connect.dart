import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import '../models/cinema.dart';
import '../storage/status_code.dart';
import '../storage/storage.dart';
import 'api_models.dart';
// 10.10.18.123
// 192.168.1.6
// 172.16.59.6
final _base = "http://172.16.59.6:8000";
final _signInURL = "/api/token/";
final _registrationEndpoint = "/api/registration/";
final _CinemaEndpoint = "/api/cinema/";

final _login = _base + _signInURL;
final _registration = _base + _registrationEndpoint;

final _cinema = _base + _CinemaEndpoint;

Future<Map> loginApi(UserLogin userLogin) async {
  final http.Response response = await http.post(
    Uri.parse(_login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  UserLoginStatusCode statusCode =
      UserLoginStatusCode.fromName(response.statusCode);
  Map<String, dynamic> reply = {
    'status': statusCode,
    'resonse_body': response.body
  };
  return reply;
}

Future<List> registrationApi(UserRegistration userRegistration) async {
  final http.Response response = await http.post(
    Uri.parse(_registration),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userRegistration.toDatabaseJson()),
  );
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));

  return result;
}

Future<List<dynamic>> theaterApi() async {
  var asd = await SecureStorage().getUsername();
  String url = _cinema;
  if (asd != null) {
    url = url + '?username=' + asd;
    print("fSFSfsefesfsef ${url}");
  }
  http.Response response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  // print(result);
  return result;
}

Future<List<dynamic>> hallApi(cinema) async {
  String url =
      'http://172.16.59.6:8000/api/cinema/${cinema.toString()}/halls/';
  http.Response response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print("fsdffdssss ${result}");
  return result;
}





// Future<Void> Anuar()